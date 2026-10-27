# Förderkreis des Museums für Glaskunst Lauscha e.V.

Lokales Paperclip-Agententeam. Steuerung über Paperclip (`http://127.0.0.1:3100`). Modelle: OpenAI über OpenCode (`OPENAI_API_KEY` in `.env`).

## Staging (einzige Arbeitsumgebung)

- **Staging-URL:** https://dev.glas-in-lauscha.de/
- **Staging-Pfad (Hestia, hart):** `/home/walter_precht/web/dev.glas-in-lauscha.de`
- **Live (nur Referenz, nicht anfassen):** https://glas-in-lauscha.de/
- **Museum (fremd, nicht unser Scope):** https://www.glasmuseum-lauscha.de/

**Zugang:** Nur WordPress-REST/MCP mit `WORDPRESS_*` in `.env` (User `paper-crew`). Kein Agent-SSH. Server-Pfad Staging zur Orientierung — Agents ändern Dateien dort nicht per Shell.

Keine Änderungen an Produktion ohne explizite Board-/Vorstands-Freigabe.

## Org & Arbeitsfluss (verbindlich)

| Rolle | Verantwortung |
| --- | --- |
| **Vorstand (CEO)** | Steuert. Priorisiert, legt Arbeitspakete an, delegiert, gibt Freigaben. Einziger, der strategisch entscheidet. |
| **Archivar** | Knowledge/`knowledge/` und Quellen aufbereiten. Darf daraus **konkrete** Folgeaufgaben vorschlagen/anlegen (Texte, Fakten) — **kein** WordPress-Schreiben. |
| **QA** | Prüft Staging & Deliverables. Meldet Befunde als **konkrete Fix-Tickets** für Web-Lead — **kein** WordPress-Schreiben. |
| **Redaktion** | Texte/Portraits/Bildunterschriften nach Auftrag des Vorstands. |
| **Web-Lead** | WordPress nur auf **zugewiesene** Tickets von QA oder Archivar (nach Vorstand-Steuerung). Keine Eigeninitiative am CMS. |

### Ablauf Website

1. Vorstand setzt Ziel / priorisiert.
2. Archivar liefert Fakten/Texte **oder** QA findet Defekte → jeweils **ein Ticket pro Fix**, klarer Soll-Zustand, Ziel-URL/ID.
3. Vorstand weist Web-Lead zu (oder bestätigt die Zuweisung).
4. Web-Lead ändert Staging **nur** im Ticket-Scope, kommentiert Diff (IDs/URLs), setzt `in_review`.
5. QA verifiziert → `done` oder Changes.

### Verbote (alle)

- Keine neuen WP-Seiten „weil sinnvoll“ ohne Ticket.
- Keine Fake-Homepages / Placeholder-Duplikate.
- Kein SSH/WP-CLI, keine Prod-Domain, keine Secrets in Issues.
- Kein Blockieren wegen „Paperclip/API nicht erreichbar“, wenn der Heartbeat läuft.
- Keine Meta-Planungs-Loops: jeder Run liefert Datei, Ticket oder WP-Diff.
- **Kein Heartbeat-Ende nur mit Prosa.** Pflicht: Paperclip-Status-Write — siehe `docs/AGENT_DISPOSITION.md`. Sonst: „Agent needs attention“.

## Aktuelle Ziele

1. **35 Jahre Förderkreis** (08.11.2026): `projects/35-jahre-förderkreis/`
2. **Website-Staging** produktionsreif: `projects/website-neuaufbau/CHECKLISTE.md` — Web-Lead nur ticketweise.

## Connector

WordPress über MCP + Application Password. Setup: `docs/wordpress-connector.md`. Secrets nur in `.env` / Paperclip Secrets — nie committen.
