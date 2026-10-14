#Requires AutoHotkey v2.0

global ErrorRate := 0.5 ; Fehlerquote in %

global currentText := ""
global lastClipboard := ""
global textIndex := 1
global Alphabet := "abcdefghijklmnopqrstuvwxyz"
global ih := InputHook()

; NEU: Speichert den Zeitpunkt des letzten Fehlers
global lastErrorTime := 0 

ih.KeyOpt("{All}", "N S") 
ih.KeyOpt("{F2}{F3}{Esc}", "-S -N")
ih.OnKeyDown := OnAnyKeyPress

F2:: {
    global ih, currentText, lastClipboard, textIndex, lastErrorTime
    if (ih.InProgress) {
        StopBot("Manueller Modus DEAKTIVIERT")
    } else {
        currentText := StrReplace(A_Clipboard, "`r", "")
        lastClipboard := currentText
        textIndex := 1
        lastErrorTime := 0
        
        if (currentText == "") {
            ShowStatus("Fehler: Zwischenablage ist leer! Lade Tipp10 neu oder drücke Alt+C.")
            return
        }
        ih.Start()
        ShowStatus("AKTIVIERT! Tippe auf der Tastatur! (F2 = Aus | F3 = Resync)")
    }
}

; NEU: Notfall-Taste, um den Zähler sofort auf den Anfang der Zwischenablage zurückzusetzen
~F3:: {
    global currentText, lastClipboard, textIndex
    if (ih.InProgress) {
        currentText := StrReplace(A_Clipboard, "`r", "")
        lastClipboard := currentText
        textIndex := 1
        ShowStatus("Bot synchronisiert! (TextIndex = 1)")
    }
}

~Esc:: {
    if (ih.InProgress) {
        StopBot("Notfall-Stopp!")
    }
}

StopBot(msg) {
    global ih
    if (ih.InProgress) {
        ih.Stop()
    }
    ShowStatus(msg)
}

ShowStatus(msg) {
    ToolTip msg
    SetTimer () => ToolTip(), -2500
}

OnAnyKeyPress(ihObj, VK, SC) {
    global currentText, lastClipboard, textIndex, ErrorRate, Alphabet, lastErrorTime
    
    ; --- ANTI-STAU-LOGIK ---
    ; Ignoriert alle gedrückten Tasten, solange wir uns in den 350ms nach einem Fehler befinden.
    ; Das verhindert den tödlichen Tasten-Stau bei gedrückt gehaltener Taste.
    if (A_TickCount - lastErrorTime < 350) {
        return 
    }
    
    currentText := StrReplace(A_Clipboard, "`r", "")
    
    if (currentText != lastClipboard) {
        lastClipboard := currentText
        textIndex := 1
    }
    
    if (textIndex > StrLen(currentText)) {
        return 
    }

    currentChar := SubStr(currentText, textIndex, 1)

    ; --- FEHLER-SIMULATION ---
    if (ErrorRate > 0 && RegExMatch(currentChar, "[a-zA-Z]") && Random(0.0, 100.0) <= ErrorRate) {
        wrongChar := SubStr(Alphabet, Random(1, StrLen(Alphabet)), 1)
        SendText wrongChar
        
        ; Merkt sich die aktuelle Uhrzeit für die Sperre, statt das Skript schlafen zu legen
        lastErrorTime := A_TickCount 
        return 
    }

    ; --- RICHTIGES ZEICHEN TIPPEN ---
    if (currentChar == "`n") {
        Send "{Enter}"
    } else {
        SendText currentChar
    }
    
    textIndex++
}
