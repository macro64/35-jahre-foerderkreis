# Application Password eintragen

1. WP-Admin Staging → Application Password „Paperclip“ erzeugen
2. In der Repo-Root:

```bash
cp .env.example .env
# WORDPRESS_USERNAME und WORDPRESS_APP_PASSWORD setzen
./scripts/wp-rest-smoke.sh
```

3. Optional Paperclip UI → Company Secrets → Key `WORDPRESS_APP_PASSWORD` (local_encrypted)

Der Connector ist vorbereitet (`opencode.json` + Docs). Ohne Passwort können Agents die REST-API nur öffentlich lesen.
