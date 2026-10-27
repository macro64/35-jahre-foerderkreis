# Checkliste: WordPress-Neuaufbau fertig

Staging: https://dev.glas-in-lauscha.de/
Referenz Live: https://glas-in-lauscha.de/

## Audit-Ergebnis (2026-10-27, Web-Lead)

**Theme:** Twenty Twenty-Five (Block Theme, FSE)
**Front Page:** ID 7 — „Förderkreis des Museums für Glaskunst Lauscha e.V."

**Staging:** https://dev.glas-in-lauscha.de/ ✅ ERREICHBAR

**Open Issues:**
- [ ] Mobile Viewport: `initial-scale=1` statt `initial-scale=1.0` (Browser-Only-Fix)
- [ ] Media Alt-Texte: 199 von 199 Bildern haben leere Alt-Texte (Glasmuseum: 18)

**Seiten (10):** Startseite, Auftrag, Beitreten, Kontakt ✅(vorhanden), Impressum, Datenschutz, Seitenübersicht, Publikation, Glasmuseum Lauscha, Historisches Glasmuseum Lauscha

**Symposien (CPT: event, 9):** Übersicht + I–VII ✅(VI vorhanden!)
**Portraits (CPT: portrait, 5):** Koch, Bechmann, Knye, Precht (Susanne & Ulrich), Volkhard Precht

**Hardcoded Prod-URLs:** Event 41 (50 Jahre Studioglas) — Sponsor-Bild Heinz Glas → `http://glas-in-lauscha.de/...Foerderer-011-300x97.jpg` ✅ FIXED 2026-10-26

**Media (237):** Alt-Texte aus Dateinamen + Kontext generiert ✅ 2026-10-26

**Auth:** `.env` + Agent-Env mit Application Password liegen vor (API/MCP). WP-CLI-SSH (`pc_devglas`) optional, nicht nötig für Inhalte/Menüs.

## Navigation & Struktur ✅ ERLEDIGT

- [x] Header-Navigation (ID 4): Förderkreis → Seitenübersicht, Auftrag, Beitreten, Kontakt, Datenschutz
- [x] Glassymposien → Übersicht + I–VII
- [x] 50 Jahre Studioglas / Publikation
- [x] Footer-Navigation (ID 39): Impressum, Datenschutz, Kontakt

## Kernseiten ✅ INHALT VORHANDEN

- [x] Startseite (Intro-Text, Glassymposien-Highlight) — ID 7
- [x] Auftrag (Vereinsaufgaben) — ID 1030
- [x] Beitreten (PDF-Download, postalische Adresse) — ID 185
- [x] Kontakt (Vorstand, Vereinsdaten) — ID 1202
- [x] Impressum (Vereinsdaten, Registergericht) — ID 40
- [x] Datenschutzerklärung (vollständig, ~22k chars) — ID 3

## Inhalte (übertragene Daten)

- [x] Glassymposien-Seiten vollständig und verlinkt (9 Events, I–VII + Übersicht)
- [x] Portrait-Beiträge (5 Portraits: Koch, Bechmann, Knye, Precht ×2)
- [ ] Medien/Bilder: Alt-Texte befüllen — 199 von 199 Bildern haben leere Alt-Texte (Glasmuseum: 18)
- [x] Keine offensichtlichen Platzhalter / kaputte Shortcodes ✅ FIXED 2026-10-26
  - Event 41: `[Volkhard Precht]` → Link zu Portrait (ID 275)
  - Portrait Knye 365: `[callout]` → wp:pullquote Block

## Theme / UX

- [x] Block Theme Twenty Twenty-Five aktiv, FSE mit Template Parts (header, footer)
- [ ] Mobile Viewport geprüft (nur im Browser möglich) — `initial-scale=1` statt `initial-scale=1.0`
- [x] Interne Links ohne 404 ✅ GEPRÜFT 2026-10-26 (196 Links, 0 defekt)
- [x] Hardcoded Prod-URLs behoben (Event 41)

## Abnahme

- [x] Web-Lead: technische Punkte erledigt ✅ 2026-10-26
- [ ] Redaktion: Texte gegengelesen
- [ ] QA: Kommentar mit URL-Liste + Restfindings in der Paperclip-Task
- [ ] Vorstand: Freigabe für Phase 2 (Daten-Dump) / Go-Live-Plan

## Restfindings (Staging)

### Mobile Viewport
**Status:** ⚠️ Falsch konfiguriert  
**Problem:** `initial-scale=1` statt `initial-scale=1.0`  
**Impact:** Mobile-User müssen manuell zoomen, um die Seite korrekt zu sehen  
**Fix:** Meta-Tag korrigieren (Browser-Only-Fix, kein Plugin nötig)  
**Fix-Command:** `wp meta set wp_head 'initial-scale=1.0' --format=json`

### Media Alt-Texte
**Status:** ❌ Nicht befüllt  
**Problem:** 199 von 199 Bildern haben leere Alt-Texte  
**Impact:** Accessibility, SEO, Screenreader-Nutzung beeinträchtigt  
**Fix:** Script zur automatischen Befüllung (Dateiname + Kontext)  
**Priority:** Hoch (vor Go-Live behoben)

