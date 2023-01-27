﻿SendMode Input

;; for italian keyboard

;; hotstring options
;; * - executes without ending char (enter space tab .)
;; ? - will trigger even when it's inside another word
;; o - omit ending character (space)

;; hotkey options
;; ^ - ctrl
;; ! - alt
;; + - shift

;; unicode characters
;; specific to chars missing on an italian keyboard
:*?o:-a'::á
:*?o:-e^::ê
:*?o:-o^::ô
:*?o:-o'::ó
:*?o:-o..::ö
:*?o:-o0::°
:*?o:-oo::º
:*?o:-i.::ï
:*?o:-dia.::Ø

;; for the article title -t
:*?o:-tep::Eau De Parfum
:*?o:-tet::Eau De Toilette
:*?o:-tec::Eau De Cologne
:*?o:-tia::Integratore Alimentare
:*?o:-tdi::Difese Immunitarie

;; for the article description -d
:*?o:-dcon::<b>Consigli d'uso</b><br>`n
:*?o:-dfor::<b>Formato</b><br>`n
:*?o:-ding::<b>Ingredienti</b><br>`n
:*?o:-dnot::<b>Note Olfattive</b><br>`n
:*?o:-dcol::<b>Colore</b><br>`n
:*?o:-dmis::<b>Misura</b><br>`n
:*?o:-dtip::<b>Tipologia</b><br>`n
:*?o:-dcap::<b>Capacità</b><br>`n

;; for the article unit -u
:*?o:-ucm::Compresse
:*?o:-ucp::Capsule
:*?o:-utv::Tavolette
:*?o:-ubs::Bustine
:*?o:-ups::Pastiglie
:*?o:-uov::Ovalette
:*?o:-upr::Perle
:*?o:-ufl::Flaconcini

;; html elements
:*?o:-br::<br>
:*?o:-pp::<p></p>
:*?o:-pt::&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;block break line

;; used to break paragraphs instead of p block - shorter distance
:*?o:-bl::<span style="display:block; margin-bottom:1em"></span>

;; for these hotkeys one would highlight the word/words and press
;; the hotkeys

;; italic
!i::
Send, ^c
Send, <i>^v</i>
return

;; bold
!b::
Send, ^c
Send, <b>^v</b>
return

;; bold-italic
!s::
Send, ^c
Send, <b><i>^v</i></b>
return

;; desc title bold
^!b::
Send, !u
Send, ^c
Send, <b>^v</b><br>`n
return


;; u-list with normal margin
;; cut or copy items to work on them - one must first sanitize the
;; entries (remove trailing semicolons or periods)
:*?o:-mlist::
Send, <br>`n<ul>
ListMaker()
send, `n</ul>`n<br>
return


ListMaker(){
    itemList := StrSplit(clipboard, "`r`n")
    trimmedList := []

    ;; clean the list and remove empty entries and trim spaces
    for idx, val in itemList{
        if (val = ""){
            Continue
        }
        
        trimmedList.Push(trim(val))
    }

    for idx, val in trimmedList{
        sendinput, `n`t<li>`n`t`t%val%`r`n`t</li>

		;add newline after closing li except the last one
		if (idx != trimmedList.Length()){
            sendinput, `n
        }
    }
}