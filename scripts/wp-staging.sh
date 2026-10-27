#!/usr/bin/env bash
# Entfernt: Agent-SSH (pc_devglas) wurde absichtlich zurückgebaut.
# WP-CLI bleibt auf dem Server unter:
#   /home/walter_precht/bin/wp-dev-glas
#   /home/walter_precht/bin/wp
# Agents nutzen nur WordPress REST/MCP (WORDPRESS_* in .env).
echo "Error: Agent-SSH ist deaktiviert. Nutze WordPress-API/MCP (WORDPRESS_*)." >&2
exit 1
