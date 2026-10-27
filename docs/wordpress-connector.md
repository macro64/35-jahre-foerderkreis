# WordPress-Connector (Staging)

Ziel: Agents (vor allem **Web-Lead**) können [dev.glas-in-lauscha.de](https://dev.glas-in-lauscha.de/) über MCP lesen und gezielt schreiben.

**Zugang:** Nur WordPress Application Password / MCP. Staging: https://dev.glas-in-lauscha.de/

## 1. Application Password (einmalig)

1. Als Admin anmelden: https://dev.glas-in-lauscha.de/wp-admin/
2. Benutzer → Profil → **Application Passwords**
3. Name: `Paperclip` → erzeugen
4. Passwort einmalig kopieren

REST prüfen:

```bash
curl -s https://dev.glas-in-lauscha.de/wp-json/ | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["url"], list(d.get("authentication",{}).keys()))'
```

## 2. Secrets lokal

```bash
cp .env.example .env
# WORDPRESS_USERNAME=...
# WORDPRESS_APP_PASSWORD=...   # Leerzeichen im App-Password sind ok
```

Niemals in Git, Issues oder Task-Kommentare schreiben. Revoke jederzeit im WP-Profil.

Optional in Paperclip UI: **Secrets** der Company — Key `WORDPRESS_APP_PASSWORD` — und dem Web-Lead freigeben.

## 3. OpenCode MCP (stdio)

Im Repo liegt `opencode.json` mit Server `wordpress` (`mcp-wordpress`). OpenCode lädt Env aus der Shell / `.env`.

Manuell testen:

```bash
set -a && source .env && set +a
npx -y mcp-wordpress
# oder Smoke via REST:
curl -s -u "$WORDPRESS_USERNAME:$WORDPRESS_APP_PASSWORD" \
  "https://dev.glas-in-lauscha.de/wp-json/wp/v2/pages?slug=&per_page=5" | python3 -m json.tool | head
```

## 4. Paperclip Connectors (optional HTTP)

Paperclip → **Connectors** → **Connect your own MCP server**, wenn du einen HTTP/SSE-MCP vor dem stdio-Server betreibst (z. B. Bridge oder Automattic WordPress-MCP-Plugin auf Staging).

Empfohlene Action-Policy:

| Action-Klasse | Policy |
| --- | --- |
| Lesen (pages, posts, media list) | Allowed — Web-Lead (+ QA read-only wenn möglich) |
| Schreiben / Löschen | Ask first |
| Prod-Domains | Off |

Nur dem **Web-Lead** volle Schreibrechte; Redaktion ggf. Content-Tools; QA nur Lesen.

## 5. Smoke-Test

Paperclip-Task an Web-Lead:

> Antworte mit dem Seitentitel der Startseite von Staging (dev.glas-in-lauscha.de). Keine Änderungen vornehmen.

Erwartung: korrekter Titel aus REST/MCP, kein Schreibzugriff nötig.

## 6. Troubleshooting

| Problem | Check |
| --- | --- |
| 401 Unauthorized | Username + Application Password, HTTPS |
| Application Passwords disabled | Hosting/Plugin blockiert — Admin fragen |
| MCP startet nicht | `WORDPRESS_SITE_URL` ohne trailing path; Node/npx erreichbar |
| Agent sieht Tools nicht | OpenCode-MCP in `opencode.json`; Paperclip mit `./scripts/start-paperclip.sh` neu starten |
