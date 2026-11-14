#!/usr/bin/env bash
# Run the base revision's policy against PR history; never execute the PR's code.
set -euo pipefail

cd -- "$PR_DIR"
HEAD_SHA=$(git rev-parse --verify HEAD)
for sha in "$BASE" "$HEAD_SHA"; do
  [[ $sha =~ ^[0-9a-f]{40}$ ]] || { echo '::error::invalid base or head commit'; exit 1; }
done
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
curl -sSfL -o "$tmp/gl.tgz" https://github.com/gitleaks/gitleaks/releases/download/v8.21.2/gitleaks_8.21.2_linux_x64.tar.gz
echo "5bc41815076e6ed6ef8fbecc9d9b75bcae31f39029ceb55da08086315316e3ba  $tmp/gl.tgz" | sha256sum -c -
tar -xzf "$tmp/gl.tgz" -C "$tmp" gitleaks
# The PR must not configure its own scanner (AUG-958): drop its gitleaks files from this scan-only
# checkout, use the built-in rules, an ignore file outside the checkout, and ignore gitleaks:allow.
# --text beats a .gitattributes binary mark; first-parent diffs show secrets added in merge commits.
rm -rf -- .gitleaks.toml .gitleaksignore
printf '[extend]\nuseDefault = true\n' > "$tmp/gitleaks.toml"
"$tmp/gitleaks" git --no-banner --redact --config "$tmp/gitleaks.toml" \
  --gitleaks-ignore-path "$tmp/no-ignore-file" --ignore-gitleaks-allow \
  --log-opts="--text --no-textconv --no-ext-diff --diff-merges=first-parent $BASE..$HEAD_SHA" .

files=$(gh api --paginate "repos/$REPO/pulls/$PR/files?per_page=100" --jq '.[] | .filename, (.previous_filename // empty)')
# An absent optional list is allowed; API failures must still fail the check.
entries=$(gh api "repos/$REPO/contents/.github?ref=$BASE" --jq '.[].name')
listed=''
if grep -Fxq 'safety-critical.txt' <<< "$entries"; then
  listed=$(gh api -H 'Accept: application/vnd.github.raw' "repos/$REPO/contents/.github/safety-critical.txt?ref=$BASE")
fi
# Public/Lucky Cat profile: changes to the CI workflow require owner review.
rules=$(printf '%s\n%s\n%s\n' '^\.github/(scripts/safety\.sh|safety-critical\.txt|workflows/ci\.yml)$ :: changes the merge safety check itself' \
  '(^|/)(\.gitleaks|\.gitattributes$) :: changes what the secret scan sees' "$listed")
fail=0
while IFS= read -r line; do
  case "$line" in ''|'#'*) continue ;; esac
  re=${line%% :: *}; why=${line#* :: }
  if hit=$(grep -E -m1 -- "$re" <<< "$files"); then
    echo "::error::needs owner: $hit ($why)"
    fail=1
  elif [ "$?" -ne 1 ]; then
    echo '::error::invalid critical-path rule on the base revision'
    exit 1
  fi
done <<< "$rules"
[ "$fail" -eq 0 ] && echo 'no critical effect listed for the changed files'
exit "$fail"
