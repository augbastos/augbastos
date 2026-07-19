# Augusto Bastos

**AI Engineer — multi-agent orchestration & MCP servers, shipped end to end, solo.**
Open source, runnable, documented.

Based in Limerick, Ireland. I design and build AI systems where multiple models, tools, and services cooperate on a real problem — agent councils that propose, debate, and adversarially verify; MCP servers that give LLMs safe hands on real APIs; and the unglamorous plumbing (multi-tenant data, auth, billing, deploys) that real products need underneath.

Most product source is private — it's commercial. Everything below is **open, runnable, or written up as a case study** you can read end to end.

<p align="center">
  <a href="https://github.com/augbastos/devcard">
    <img src="https://card.devcard.workers.dev/svg?user=augbastos" alt="live devcard — real-time AI coding stats" />
  </a>
</p>
<p align="center"><em>↑ Live — this card updates within seconds of me writing code. Built with <a href="https://github.com/augbastos/devcard">devcard</a> (open source, works with any AI coding agent).</em></p>

---

## Multi-agent & MCP

**🧾 deputy-mcp — open-source MCP server for Deputy (workforce management)**
Self-hosted alternative to the hosted Deputy connectors: your token stays on your machine. Three auth modes (API token, OAuth 2.0 with loopback flow, iCal fallback), self-service `/my/*` endpoints so a plain employee token works — no manager permissions needed — and graceful degradation when access is denied. Python + FastMCP, 360+ tests, writes locked behind an opt-in flag.
→ [Repo](https://github.com/augbastos/deputy-mcp)

**⚖️ council — a deliberation engine that distrusts its own consensus**
Five lenses propose independently, debate, then the pipeline *computes* convergence (which claims multiple lenses reached alone), adversarially attacks the top claims with dedicated refuters, and only lets a neutral chair synthesize from what survived. Runs against any repo or question; heterogeneous models per lens; a deterministic mock backend runs the full pipeline offline. Source private for now — I'm happy to walk through it.

**🏛️ etica — a multi-agent book production pipeline**
An agent-orchestrated pipeline that turns a public-domain source text into a typeset book — print PDF, EPUB3/Kindle, generative cover art, multi-language — with quality gates that block a stage when the previous one fails. Pipeline + a Part I sample are public; the full adapted prose is a separate paid edition.
→ [Repo](https://github.com/augbastos/etica)

**📡 Wavr — explainable multi-modal sensor fusion, privacy-first**
Fuses network scan, WiFi CSI, camera pose, and mmWave radar into one *explainable* room-occupancy state — `confidence = agreement × strength`, and the dashboard always shows *why*. Ships its own MCP server, so an LLM agent can ask the house what's happening. Loopback-only, camera frames never stored. Python 3.11 + FastAPI, 1,300+ tests green in CI, AGPL-3.0. Runs with no hardware — off-localhost the frontend self-switches to a simulator.
→ [Repo](https://github.com/augbastos/wavr)

---

## Products & case studies

**🐱 Lucky Cat — multi-tenant restaurant SaaS**
Two full apps on one backend: **Ownly** (owner dashboard — shifts, payroll, stock, cash-up, live orders board) and **Tillr** (customer ordering PWA with real-time tracking). Postgres **Row-Level Security** as the isolation boundary, **Stripe Connect** wired for split payments, Cloudflare edge. Built end to end in under two months, solo; demo-complete and awaiting its first commercial rollout.
→ [Case study](https://github.com/augbastos/lucky-cat-case-study) · [Ownly demo](https://lucky-cat.pages.dev/template/ownly/) · [Tillr demo](https://lucky-cat.pages.dev/template/tillr/)

**🛩️ PitchPilot — field-sales companion with a RAG copilot**
A white-label app for door-to-door reps. Its core is **Wingman**, a retrieval-augmented copilot (Supabase **pgvector** + **Gemini**) that answers a rep's question from the product's own playbook — grounded and cited. The case study is the honest version: an IVFFlat recall collapse on a tiny corpus, a thinking-token budget eating the output, and a cost-ordered model fallback under quota — what actually broke and how I fixed it.
→ [Case study](https://github.com/augbastos/pitchpilot-case-study) · [Live demo](https://lucky-cat.pages.dev/pitcher-template/)

**🔎 rag-demo — the retrieval pipeline, runnable**
A minimal, clone-and-run RAG pipeline: chunk → embed → **pgvector** → grounded answer that refuses to invent. `docker compose up`, a local `sentence-transformers` model for keyless indexing, pytest, and a `match_chunks()` SQL function shaped like a Supabase RPC. The inspectable code behind my copilots.
→ [Repo](https://github.com/augbastos/rag-demo)

**🪪 devcard — live dev stats card for the AI coding era**
The card at the top of this page. A local hook captures real AI-assisted coding output (not editor time), syncs an **anonymized** copy — language, line counts, never project names or code — to a Cloudflare **Worker + D1** that renders a live, embeddable SVG: i18n by viewer language, auto dark/light, pinned repos with live stars, auto Sponsor button. Hooks git itself, so it works with **Claude Code, Codex, Cursor, local models — anything that commits**. One-command setup. MIT.
→ [Repo](https://github.com/augbastos/devcard)

---

## Stack

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![pgvector](https://img.shields.io/badge/pgvector-4169E1?style=flat&logo=postgresql&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3FCF8E?style=flat&logo=supabase&logoColor=white)
![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?style=flat&logo=cloudflare&logoColor=white)
![Stripe](https://img.shields.io/badge/Stripe-635BFF?style=flat&logo=stripe&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)

**Working with:** Python · multi-agent orchestration · MCP (Model Context Protocol) · LLM pipelines & RAG (pgvector, sentence-transformers) · Claude & Gemini APIs · FastAPI · Postgres + RLS · Supabase Edge Functions · Cloudflare Pages/Workers · Stripe Connect · TypeScript/React · Git-based CI.

---

## Get in touch

Open to freelance and AI-engineering roles — multi-agent systems, MCP servers, RAG pipelines, and full-stack products built to ship.

- 🌐 Portfolio & CV — [augustobastos.pages.dev](https://augustobastos.pages.dev)
- 💼 LinkedIn — [linkedin.com/in/augustobastos](https://www.linkedin.com/in/augustobastos)
- ✉️ Email — [augustobastos123@gmail.com](mailto:augustobastos123@gmail.com)
