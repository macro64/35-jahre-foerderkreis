#!/usr/bin/env bash
# Read-only smoke test against Staging WordPress REST API.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -f "$ROOT/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT/.env"
  set +a
fi

SITE="${WORDPRESS_SITE_URL:-https://dev.glas-in-lauscha.de}"
SITE="${SITE%/}"

echo "Public site info:"
curl -sf "$SITE/wp-json/" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("name") or "(no name)", d.get("url"), "front=", d.get("page_on_front"))'

if [[ -n "${WORDPRESS_USERNAME:-}" && -n "${WORDPRESS_APP_PASSWORD:-}" ]]; then
  echo
  echo "Authenticated /users/me:"
  curl -sf -u "$WORDPRESS_USERNAME:$WORDPRESS_APP_PASSWORD" "$SITE/wp-json/wp/v2/users/me" \
    | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("name"), d.get("slug"), "roles=", d.get("roles"))'
  echo
  echo "Front page title:"
  FRONT=$(curl -sf "$SITE/wp-json/" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("page_on_front") or "")')
  if [[ -n "$FRONT" ]]; then
    curl -sf "$SITE/wp-json/wp/v2/pages/$FRONT" \
      | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["title"]["rendered"])'
  fi
else
  echo
  echo "Hinweis: WORDPRESS_USERNAME / WORDPRESS_APP_PASSWORD nicht gesetzt — nur öffentlicher Check."
  echo "Siehe docs/wordpress-connector.md"
fi
