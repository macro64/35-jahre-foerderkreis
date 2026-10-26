#!/usr/bin/env bash
# Start Paperclip with LM Studio (OpenCode BYOK) for Förderkreis Lauscha.
set -euo pipefail

# LM Studio OpenAI-compatible server (default port)
LMSTUDIO_BASE_URL="${LMSTUDIO_BASE_URL:-http://127.0.0.1:1234/v1}"
# Model id as reported by GET /v1/models — override if you load another model
LMSTUDIO_MODEL_ID="${LMSTUDIO_MODEL_ID:-qwen3.6-27b-mlx}"

export PAPERCLIP_TELEMETRY_DISABLED="${PAPERCLIP_TELEMETRY_DISABLED:-1}"
export DO_NOT_TRACK="${DO_NOT_TRACK:-1}"
export OPENCODE_ALLOW_ALL_MODELS=true
export PAPERCLIP_OPENCODE_SMALL_MODEL="lmstudio/${LMSTUDIO_MODEL_ID}"
export PAPERCLIP_OPENCODE_PROVIDERS="$(cat <<EOF
{"lmstudio":{"npm":"@ai-sdk/openai-compatible","name":"LM Studio","options":{"baseURL":"${LMSTUDIO_BASE_URL}"},"models":{"${LMSTUDIO_MODEL_ID}":{}}}}
EOF
)"

echo "LM Studio: ${LMSTUDIO_BASE_URL}"
echo "Model:     lmstudio/${LMSTUDIO_MODEL_ID}"
echo "UI:        http://127.0.0.1:3100"
echo

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# Fail early + ensure context length (>=64k) for Paperclip prompts
bash "$ROOT/scripts/ensure-lmstudio-context.sh"

# Prefer instance .env (also holds LM Studio vars after setup); shell exports above still win for this process.
npx --yes paperclipai@latest run "$@"
