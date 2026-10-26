# Skill: wp-page-audit

Prüfe eine Staging-Seite auf Vollständigkeit und technische Qualität.

## Schritte

1. Seite über WordPress-MCP oder REST laden (`/wp-json/wp/v2/pages?slug=…`)
2. Titel, Status (`publish`), Inhalt, Featured Media notieren
3. Menü-Zuordnung prüfen (ob verlinkt)
4. Interne Links und Medien-URLs stichprobenartig öffnen
5. Ergebnis kurz in die Paperclip-Task kommentieren: OK / Findings / TODOs

## Scope

Nur https://dev.glas-in-lauscha.de/ — keine Prod-Änderungen.
