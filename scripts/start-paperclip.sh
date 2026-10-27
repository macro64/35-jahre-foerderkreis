#!/usr/bin/env bash
# Start Paperclip for Förderkreis Lauscha.
# Default: OpenAI (OPENAI_API_KEY in .env). LM Studio optional fallback.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ -f "$ROOT/.env" ]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT/.env"
  set +a
  echo "Env:       $ROOT/.env"
else
  echo "Warn:      $ROOT/.env fehlt" >&2
fi

export PAPERCLIP_TELEMETRY_DISABLED="${PAPERCLIP_TELEMETRY_DISABLED:-1}"
export DO_NOT_TRACK="${DO_NOT_TRACK:-1}"
export OPENCODE_ALLOW_ALL_MODELS=true

OPENAI_MODEL_ID="${OPENAI_MODEL:-gpt-4o-mini}"
LMSTUDIO_BASE_URL="${LMSTUDIO_BASE_URL:-http://127.0.0.1:1234/v1}"
LMSTUDIO_MODEL_ID="${LMSTUDIO_MODEL_ID:-qwen3.5-9b-mlx}"

if [ -n "${OPENAI_API_KEY:-}" ]; then
  export OPENAI_API_KEY
  export PAPERCLIP_OPENCODE_SMALL_MODEL="openai/${OPENAI_MODEL_ID}"
  # OpenCode uses OPENAI_API_KEY natively for provider "openai"
  unset PAPERCLIP_OPENCODE_PROVIDERS || true
  echo "Provider:  OpenAI"
  echo "Model:     openai/${OPENAI_MODEL_ID}"
else
  echo "Warn:      OPENAI_API_KEY fehlt in .env — Fallback LM Studio" >&2
  export PAPERCLIP_OPENCODE_SMALL_MODEL="lmstudio/${LMSTUDIO_MODEL_ID}"
  export PAPERCLIP_OPENCODE_PROVIDERS="$(cat <<EOF
{"lmstudio":{"npm":"@ai-sdk/openai-compatible","name":"LM Studio","options":{"baseURL":"${LMSTUDIO_BASE_URL}"},"models":{"${LMSTUDIO_MODEL_ID}":{}}}}
EOF
)"
  echo "Provider:  LM Studio (${LMSTUDIO_BASE_URL})"
  echo "Model:     lmstudio/${LMSTUDIO_MODEL_ID}"
  bash "$ROOT/scripts/ensure-lmstudio-context.sh"
fi

echo "UI:        http://127.0.0.1:3100"
echo

npx --yes paperclipai@latest run "$@"
