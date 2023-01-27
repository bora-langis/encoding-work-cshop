SendMode Input

;u-list with normal margin
!l::
Send, ^x
Send, <br><ul style="margin-bottom:0;">
ListMaker("-")
send, `n</ul><br>
return

;header 1
!h::
Send, ^c
Send, <h2>^v</h2>
return

;header 2 with margin
^!h::
Send, ^c
Send, <h3 style="margin-top:-5px;">^v</h3>
return

;header 2 no margin
^+h::
Send, ^c
Send, <h3>^v</h3>
return

;break line
:*?o:-br::<br>

;block break line
:*?o:-bl::<span style="display:block; margin-bottom:1em"></span>

;2 break line
:*?o:-2br::<br><br>

;end p elements
:*?o:-pe::</p>

;add tab
:*?o:-tb::&nbsp;&nbsp;&nbsp;&nbsp;-

;copy
NumpadSub::^c

;paste
NumpadAdd::^v

;italic
!i::
Send, ^c
Send, <i>^v</i>
return

;bold
!b::
Send, ^c
Send, <b>^v</b>
return

;bold ctrl header 3
^!b::
Send, ^+u
Send, ^c
Send, <span style="display:block; margin-bottom:1em"></span>`n
Send, <b>^v</b><br>
return

;strong
!s::
Send, ^c
Send, <b><i>^v</i></b>
return

;;paragraph styles
:*?o:-p0::
Send, ^v<br><br>

;;unicode characters
:*?o:-a?::á
:*?o:-a'::à
:*?o:-ae::æ
:*?o:-e'::é
:*?o:-e?::è
:*?o:-e^::ê
:*?o:-o^::ô
:*?o:-o'::ó
:*?o:-o..::ö
:*?o:-o0::°
:*?o:-oo::º
:*?o:-i^::î
:*?o:-i'::í

;;shortcuts
:*?o:-edp::Eau De Parfum
:*?o:-edt::Eau De Toilette
:*?o:-ia::Integratore Alimentare
:*?o:-bi::Benessere Intestinale
:*?o:-rti::Regolarità Del Transito Intestinale
:*?o:-bdm::Benessere Del Microcircolo
:*?o:-rpa::Regolarità Della Pressione Arteriosa

:*:-om::
OlfattiveMaker()
return

ListMaker(myDelim){
    temp := strreplace(clipboard, "`r`n", "-")
    itemList := StrSplit(temp, myDelim)
    trimmedList := []

    ;; clean the list and remove empty entries and trim spaces
    for idx, val in itemList{
        if (val = ""){
            Continue
        }
        
        trimmedList.Push(trim(val))
    }

    for idx, val in trimmedList{
        sendinput, `n`t<li>`n`t`t %val%</li>

        if (idx != trimmedList.Length()){
            sendinput, `n
        }
    }
}

OlfattiveMaker(){
	temp := RegExReplace(clipboard, "([a-zA-Z ]*\s*?sono\s*)|([a-zA-Z ]*\s*?:\s*)","")
	temp2 := strsplit(RegExReplace(temp, "(\r\n)|(;)", "-"), "-", " `t.")

	trimmedList := []
    capHolder := 0

    ;; clean the list and remove empty entries and trim spaces
    for idx, val in temp2{
        if (val = ""){
            Continue
        }
        
        trimmedList.Push(trim(val))
    }

	sendinput, <p></p>
	sendinput, % "<b>Testa</b>: " trimmedList[1] "<br>`n"
	sendinput, % "<b>Cuore</b>: " trimmedList[2] "<br>`n"
	sendinput, % "<b>Fondo</b>: " trimmedList[3] "`n"
}
