# Nächste Schritte

## Erledigt (Korrekturen)

- LM Studio Kontext auf **65536** geladen (vorher 8192 → Prompt-Fehler)
- Workspace auf ASCII-Pfad `foerderkreis` + Git-Initialcommit
- Agent-Timeouts auf 1800s; Heartbeats nur Web-Lead aktiv
- **FRD-2 Smoke-Test: done** — Seitentitel „Förderkreis des Museums für Glaskunst Lauscha e.V.“

## Noch von dir

1. WordPress Application Password → `.env` → `./scripts/wp-rest-smoke.sh`
2. **FRD-1** (WordPress-Neuaufbau) in Paperclip starten / Web-Lead zuweisen lassen
3. Vor jedem Paperclip-Start: `./scripts/ensure-lmstudio-context.sh` (macht auch `start-paperclip.sh`)

UI: http://127.0.0.1:3100
