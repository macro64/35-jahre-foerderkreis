# Förderkreis Museums für Glaskunst Lauscha — Paperclip-Crew

Lokales Agententeam mit [Paperclip](https://github.com/paperclipai/paperclip), BYOK über **LM Studio** + **OpenCode**, Zielsite **Staging** [dev.glas-in-lauscha.de](https://dev.glas-in-lauscha.de/).

## Voraussetzungen

| Tool | Status / Hinweis |
| --- | --- |
| Node.js ≥ 24.11 | `node --version` |
| LM Studio | Modell laden, Local Server auf `http://127.0.0.1:1234/v1` |
| OpenCode CLI | `brew install anomalyco/tap/opencode` |
| WordPress Application Password | Staging-Admin → Profil → Application Passwords |

Aktuell konfiguriertes Modell: `lmstudio/qwen3.6-27b-mlx` (anpassbar via `LMSTUDIO_MODEL_ID`).  
In LM Studio **Context Length ≥ 32k** einstellen (sonst scheitern Heartbeats).

Pfad-Hinweis: macOS speichert `förderkreis` oft als NFD. Zusätzlich existiert der Symlink `../foerderkreis` → dasselbe Repo.

## Start

```bash
# 1) .env aus Vorlage (WordPress-Credentials)
cp .env.example .env
# WORDPRESS_USERNAME / WORDPRESS_APP_PASSWORD eintragen

# 2) Paperclip mit LM-Studio-Env
chmod +x scripts/start-paperclip.sh
./scripts/start-paperclip.sh
```

UI: http://127.0.0.1:3100

Company-IDs und Agenten: `.paperclip-company.json` (lokal erzeugt).

## WordPress-Connector

Siehe [docs/wordpress-connector.md](docs/wordpress-connector.md). Kurz:

1. Application Password auf Staging anlegen
2. Werte in `.env` setzen
3. MCP für OpenCode: `opencode.json` (stdio `mcp-wordpress`)
4. Optional in Paperclip: Connectors → eigenes MCP

Smoke-Test-Task: „Antworte mit dem Seitentitel der Startseite von Staging.“

## Org & erste Aufgabe

- Vorstand · Web-Lead · Redaktion · QA — alle `opencode_local` / LM Studio
- Goal: WordPress-Neuaufbau produktionsreif
- Issue: WordPress-Neuaufbau fertigstellen → Web-Lead
- Checkliste: [projects/website-neuaufbau/CHECKLISTE.md](projects/website-neuaufbau/CHECKLISTE.md)

## Docs

- [docs/lmstudio-opencode.md](docs/lmstudio-opencode.md) — BYOK-Env
- [docs/wordpress-connector.md](docs/wordpress-connector.md) — MCP + Secrets
- [docs/data-dump.md](docs/data-dump.md) — Phase 2 Daten-Dump
- [AGENTS.md](AGENTS.md) — Kontext für Agents

## Phase 2

Nach Website-Done: Daten unter `data/` dumpen (gitignored). Siehe `docs/data-dump.md`.
