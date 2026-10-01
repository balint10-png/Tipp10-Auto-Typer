# Tipp10 Auto-Typer (Tampermonkey + AutoHotkey v2)

Ein zweiteiliges Automatisierungs-Tool für die 10-Finger-Schreibtrainer-Webseite Tipp10. Es liest den vorgegebenen Text in Echtzeit aus dem Browser aus und tippt ihn automatisch über simulierte Tastatureingaben ab. 

Das Tool besteht aus einem **Tampermonkey-Skript** (welches den Text extrahiert und in die Zwischenablage kopiert) und einem **AutoHotkey-Skript** (welches die Zwischenablage ausliest und die Tasten drückt).

## Features
- **Echtzeit-Synchronisation:** Erkennt neue Zeilen und aktualisiert den Text nahtlos.
- **Menschliche Fehler-Simulation:** Konfigurierbare Fehlerquote (z.B. 0.5%), bei der das Skript absichtlich falsche Tasten drückt und menschliche Verzögerungen einbaut.
- **Notfall-Stopp:** Jederzeit pausierbar.

## Voraussetzungen
1. **Tampermonkey:** Browser-Erweiterung (Chrome, Firefox, Edge, etc.)
2. **AutoHotkey v2:** Muss auf dem Windows-PC installiert sein ([Download](https://www.autohotkey.com/))

## Installation

### 1. Tampermonkey Skript installieren
1. Öffne das Tampermonkey-Dashboard in deinem Browser.
2. Klicke auf den Tab **Neues Skript hinzufügen**.
3. Lösche den vorhandenen Code und kopiere den gesamten Inhalt der Datei `tipp10_scraper.user.js` in das Fenster.
4. Speichere das Skript (Datei -> Speichern oder `Strg + S`).

### 2. AutoHotkey Skript einrichten
1. Erstelle eine neue Textdatei auf deinem Computer und nenne sie `tipp10_autotyper.ahk`.
2. Öffne die Datei mit einem Texteditor (z.B. Notepad) und füge den Code aus der Datei `tipp10_autotyper.ahk` ein.
3. Speichere die Datei.
4. Führe die Datei per Doppelklick aus (es erscheint ein grünes "H"-Symbol in der Taskleiste unten rechts).

## Bedienung
1. Öffne Tipp10 im Browser und starte eine beliebige Schreibübung.
2. Drücke **F2**, um den Auto-Typer zu aktivieren.
3. Beginne einfach auf deiner physischen Tastatur zu tippen (egal welche Tasten) – das Skript fängt deine Eingaben ab und tippt stattdessen die korrekten Buchstaben aus der Lektion.
4. **F2** oder **ESC** drücken, um den Bot zu pausieren/stoppen.

### Fehlerquote anpassen
Öffne die `.ahk`-Datei in einem Editor und ändere in der ersten Zeile den Wert von `ErrorRate`.
- `global ErrorRate := 0.0` (0% Fehler, perfekt)
- `global ErrorRate := 0.5` (Ein Fehler ca. alle 200 Anschläge)
- `global ErrorRate := 1.2` (1,2% Fehlerquote)

### Troubleshooting
- **Skript tippt nicht weiter:** Drücke manuell `Alt + C`, um das Tampermonkey-Skript zu zwingen, den aktuellen Text sofort in die Zwischenablage zu kopieren. Lade im Zweifel die Tipp10-Seite per `F5` neu.