# LM Studio ↔ OpenCode (BYOK)

Paperclip startet Agents mit Adapter `opencode_local`. Modelle kommen lokal aus LM Studio.

## LM Studio

1. Modell laden (aktuell: `qwen3.6-27b-mlx`)
2. Local Server starten → `http://127.0.0.1:1234/v1`
3. Prüfen:

```bash
curl -s http://127.0.0.1:1234/v1/models | python3 -m json.tool
```

## Paperclip starten

```bash
./scripts/start-paperclip.sh
```

Das Skript setzt:

| Variable | Zweck |
| --- | --- |
| `PAPERCLIP_OPENCODE_PROVIDERS` | OpenAI-kompatibler Provider `lmstudio` |
| `PAPERCLIP_OPENCODE_SMALL_MODEL` | Hilfsmodell (Session-Titel etc.) |
| `OPENCODE_ALLOW_ALL_MODELS=true` | Katalog-Probe für Custom-Models überspringen |
| `PAPERCLIP_TELEMETRY_DISABLED=1` | Telemetrie aus |

Agent-Model-Feld: `lmstudio/<modell-id>` — z. B. `lmstudio/qwen3.6-27b-mlx`.

Override:

```bash
LMSTUDIO_MODEL_ID=anderes-modell ./scripts/start-paperclip.sh
```

## Hinweise

- `dangerouslySkipPermissions` muss an (Paperclip-Default für unattended), sonst greifen die Provider-Env-Overrides nicht.
- Ohne laufendes LM Studio schlägt der Start-Check im Skript fehl.
- Alternative UI: Paperclip → Connectors → Local endpoint / Chat Completions auf dieselbe URL.
- **Kontextlänge:** Paperclip/OpenCode-Prompts sind groß. In LM Studio für das Modell mindestens **32k** Context Length setzen (besser 64k+). Fehler der Form *„tokens to keep … greater than the context length“* → Kontext erhöhen und Agent-Session in Paperclip zurücksetzen.
