#!/usr/bin/env bash
# Ensure LM Studio has the Förderkreis model loaded with enough context for Paperclip/OpenCode.
set -euo pipefail

LMSTUDIO_BASE="${LMSTUDIO_BASE_URL:-http://127.0.0.1:1234}"
LMSTUDIO_BASE="${LMSTUDIO_BASE%/}"
# Strip /v1 if present
LMSTUDIO_BASE="${LMSTUDIO_BASE%/v1}"
MODEL_ID="${LMSTUDIO_MODEL_ID:-qwen3.5-9b-mlx}"
CONTEXT="${LMSTUDIO_CONTEXT_LENGTH:-65536}"

if ! curl -sf "${LMSTUDIO_BASE}/api/v0/models" >/dev/null; then
  echo "ERROR: LM Studio nicht erreichbar unter ${LMSTUDIO_BASE}" >&2
  exit 1
fi

LOADED_CTX=$(curl -sf "${LMSTUDIO_BASE}/api/v0/models" | python3 -c "
import json,sys
want='${MODEL_ID}'
best=0
for m in json.load(sys.stdin).get('data',[]):
  mid=m.get('id','')
  if mid==want or mid.startswith(want+':'):
    if m.get('state')=='loaded':
      best=max(best, int(m.get('loaded_context_length') or 0))
print(best)
")

if [[ "${LOADED_CTX}" -ge "${CONTEXT}" ]]; then
  echo "LM Studio OK: ${MODEL_ID} context=${LOADED_CTX}"
  exit 0
fi

echo "Lade ${MODEL_ID} mit context_length=${CONTEXT} (aktuell ${LOADED_CTX})…"
# Unload short instances of this model
curl -sf "${LMSTUDIO_BASE}/api/v0/models" | python3 -c "
import json,sys,urllib.request
base='${LMSTUDIO_BASE}'
want='${MODEL_ID}'
for m in json.load(sys.stdin).get('data',[]):
  mid=m.get('id','')
  if m.get('state')=='loaded' and (mid==want or mid.startswith(want+':')):
    ctx=int(m.get('loaded_context_length') or 0)
    if ctx < int('${CONTEXT}'):
      req=urllib.request.Request(base+'/api/v1/models/unload', data=json.dumps({'instance_id': mid}).encode(), method='POST', headers={'Content-Type':'application/json'})
      try:
        urllib.request.urlopen(req).read()
        print('unloaded', mid, 'ctx', ctx)
      except Exception as e:
        print('unload skip', mid, e)
"

curl -sf -X POST "${LMSTUDIO_BASE}/api/v1/models/load" \
  -H 'Content-Type: application/json' \
  -d "{\"model\":\"${MODEL_ID}\",\"context_length\":${CONTEXT},\"echo_load_config\":true}" \
  | python3 -m json.tool

echo "Fertig."
