# Pflicht: Paperclip-Disposition

## Die API ist lokal — nicht raten

Im Run sind gesetzt (vom Adapter):

- `PAPERCLIP_API_URL` → bei uns typisch `http://127.0.0.1:3100`
- `PAPERCLIP_API_KEY` → Run-JWT
- `PAPERCLIP_RUN_ID`, `PAPERCLIP_AGENT_ID`, `PAPERCLIP_TASK_ID` / Issue-ID

**Verboten:** `api.paperclip.com`, `localhost:3000`, relative `/api/...`, erfundene Domains, Support-Mails.

Zuerst prüfen:

```bash
echo "URL=$PAPERCLIP_API_URL KEY_SET=$([ -n \"$PAPERCLIP_API_KEY\" ] && echo yes || echo no) RUN=$PAPERCLIP_RUN_ID TASK=$PAPERCLIP_TASK_ID"
```

## Status auf done (Minimalbeispiel)

```bash
ISSUE_ID="${PAPERCLIP_TASK_ID:-$ISSUE_ID}"
curl -sS -X PATCH "$PAPERCLIP_API_URL/api/issues/$ISSUE_ID" \
  -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
  -H "X-Paperclip-Run-Id: $PAPERCLIP_RUN_ID" \
  -H "Content-Type: application/json" \
  -d '{"status":"done","comment":"Erledigt."}'
```

HTTP-Body muss die Issue mit `"status":"done"` zurückgeben. Sonst nicht behaupten, es sei erledigt.

## Fallback nur wenn Env leer

```bash
: "${PAPERCLIP_API_URL:=http://127.0.0.1:3100}"
```

## Ungültig

Nur Prosa / Markdown-Dateien „Status done“ schreiben / falsche Hosts → Paperclip zeigt *Agent needs attention*.
