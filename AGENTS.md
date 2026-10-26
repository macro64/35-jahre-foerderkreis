# Förderkreis des Museums für Glaskunst Lauscha e.V.

Lokales Paperclip-Agententeam. Steuerung über Paperclip (`http://127.0.0.1:3100`), Modelle über LM Studio + OpenCode.

## Staging (einzige Arbeitsumgebung)

- **Staging:** https://dev.glas-in-lauscha.de/
- **Live (nur Referenz, nicht anfassen):** https://glas-in-lauscha.de/
- **Museum (fremd, nicht unser Scope):** https://www.glasmuseum-lauscha.de/

Keine Änderungen an Produktion ohne explizite Board-/Vorstands-Freigabe.

## Org

| Rolle | Verantwortung |
| --- | --- |
| Vorstand | Ziele, Priorisierung, Freigaben |
| Web-Lead | Theme, Seiten, Menüs, Forms via WordPress-MCP |
| Redaktion | Texte, Portraits, Symposien, Bildunterschriften |
| QA | Checkliste, Links, Mobile, Impressum/DSGVO |

## Aktuelles Ziel

WordPress-Neuaufbau auf Staging produktionsreif machen. Checkliste: `projects/website-neuaufbau/CHECKLISTE.md`.

## Connector

WordPress über MCP + Application Password. Setup: `docs/wordpress-connector.md`. Secrets nur in `.env` / Paperclip Secrets — nie committen.

## Do’s / Don’ts

- Do: Staging lesen/schreiben über den freigegebenen Connector
- Do: Fortschritt in Paperclip-Tasks kommentieren
- Don’t: Prod-Domain, Hosting-DNS oder Live-DB anfassen
- Don’t: Application Passwords oder Tokens in Issues/Commits schreiben
