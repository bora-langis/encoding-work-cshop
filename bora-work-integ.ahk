SendMode Input

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
:*?o:-dia::Ø

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
:*?o:-br::<br>`n
:*?o:-pp::<p></p>{Enter 2}
:*?o:-pt::&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;block break line

;; used to break paragraphs instead of p block - shorter heigt
:*?o:-bl::<span style="display:block; margin-bottom:1em"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{Left 48}{Enter 2}

;; for the chatbot
:*?o:-bot::descrizione più elaborata di:

;; default skeleton for article
:*?o:-aaa::
Send, <p></p>{Enter 2}
Send, <b>Colore</b><br>{Enter}<p></p>{Enter 2}
Send, <b>Misura</b><br>{Enter 2}
Send, marca
return

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


;; cut or copy items to work on them - one must first sanitize the
;; entries (remove trailing semicolons or periods)

;; 2 functions on making a list
;; -lwai for editors with auto indent
;; -lnai for editors that don't have it

:*?o:-lnai::
Send, <br>`n<ul>
ListMaker()
send, `n</ul>`n<br>
return

:*?o:-lwai::
Send, <br>`n<ul>
ListMaker2()
send, `n{BS}</ul>`n<br>
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

ListMaker2(){
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
        if (idx = 1){
            sendinput, `n`t
        }else{
            sendinput, `n
        }

        sendinput, <li>`n`t%val%`r`n{BS}</li>

		;add newline after closing li except the last one
		if (idx != trimmedList.Length()){
            sendinput, `n
        }
    }
}