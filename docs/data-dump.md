# Phase 2 — Daten dumpen

Nach Abschluss des Website-Neuaufbaus auf Staging.

## Ablage

Alles unter `data/` (gitignored):

```
data/
  README.md          # Manifest: Quelle, Datum, Inhalt
  wordpress/
    content-export/  # WP-Export / WXR falls genutzt
    db/              # SQL-Dump nur lokal, nie committen
    media-inventory.json
  staging-snapshot-notes.md
```

## Empfohlene Schritte

1. Staging sichern (Hosting-Backup oder `wp db export` / phpMyAdmin)
2. Medien-Inventar: Liste der Attachments über REST (`/wp-json/wp/v2/media`)
3. Seiten-/Beitrags-Inventar: IDs, Slugs, Status
4. Manifest in `data/README.md` mit Datum und Quelle (`dev.glas-in-lauscha.de`)
5. Optional Prod-Dump nur nach Vorstands-Freigabe

## Paperclip

Issue „Daten-Dump Staging“ an Web-Lead anlegen, wenn Phase 1 (Checkliste) grün ist.
