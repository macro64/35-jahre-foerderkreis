# Nächste Schritte (manuell)

Setup ist fertig. Noch von dir:

## 1. LM Studio Kontext

Für `qwen3.6-27b-mlx` in LM Studio **Context Length ≥ 32768** setzen, Server neu starten.

Ohne das: Heartbeat-Fehler *tokens to keep … greater than the context length*.

## 2. WordPress Application Password

1. https://dev.glas-in-lauscha.de/wp-admin/ → Application Password „Paperclip“
2. `cp .env.example .env` und Credentials eintragen
3. `./scripts/wp-rest-smoke.sh` — muss authentifiziert den Startseitentitel zeigen

## 3. Paperclip UI

http://127.0.0.1:3100 — Company **Förderkreis des Museums für Glaskunst Lauscha e.V.**

- Issues: **FRD-1** Neuaufbau, **FRD-2** Smoke-Test, **FRD-3** Daten-Dump (Phase 2)
- Agents: Vorstand, Web-Lead, Redaktion, QA (`opencode_local` / `lmstudio/qwen3.6-27b-mlx`)

Start mit Env:

```bash
./scripts/start-paperclip.sh
```

## 4. Danach

Website-Checkliste abarbeiten → Phase 2 Dump (`docs/data-dump.md`).
