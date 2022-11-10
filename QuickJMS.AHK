#Singleinstance Force
#Persistent
#NoEnv
SetWorkingDir %A_ScriptDir% ;set to script directory to see files
ver := "0.0.1"
GuiVisible := false
SendMode, Input 




; VERSION CHECKER ******************************************************************************************************************************************

curUrl := "https://raw.githubusercontent.com/Olichma/QuickJMS/main/QuickJMS.AHK"  ;the URL name you would like to download the update from. 

;  THE BELOW READ THE VERSION NUMBER OF THE GITHUB PAGE.
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Olichma/QuickJMS/main/version.txt", true) ; Using 'true' and the call below allows the script to remain responsive.
whr.Send() 
whr.WaitForResponse() ;this is taken from the installer. Can also be located as an example on the urldownloadtofile page of the quick reference guide.
newVersionNum := whr.ResponseText


if(ver != newVersionNum) ; if the version numbers do not match, ask if you want to update
{
	MsgBox, 1, Press OK to download, Your current version is %ver%. This latest is %newVersionNum%.
		IfMsgBox, OK 
			goto DownloadUpdate
		else
			goto DeclinedUpdate	
}


DownloadUpdate:
	newFileName := A_ScriptDir . "\QuickJMS.ahk"
	UrlDownloadToFile, %curUrl%, %newFileName%
	if (ErrorLevel = 1){
		MsgBox, There was some error updating the file. Program closing.
	}else if (ErrorLevel = 0) {
		Msgbox, Update Complete. Please delete the old version.
	}else{ 
		MsgBox, unknown error occured. Program closing.
	}
	ExitApp

DeclinedUpdate:
	msgbox, Update cancelled. Program starting
	goto defineParticipantsGui
	return



;*************************************************************************************************************************************************************































defineParticipantsGui: ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;DEFINING BUTTONS
buttonSize := 60 					;size of one button
button2 := buttonSize
button3 := buttonSize * 2
button4 := buttonSize * 3
button5 := buttonSize * 4
button6 := buttonSize * 5

Gui, participantGui:Font, s10, Arial				; fonts

;ADDING BUTTONS
Gui, participantGui:Add, Button, x0 y0 w%buttonSize% h%buttonSize% gRPButton, RP
Gui, participantGui:Add, Button, x0 y%button2% w%buttonSize% h%buttonSize% gSuspectButton, Suspect 
Gui, participantGui:Add, Button, x0 y%button3% w%buttonSize% h%buttonSize% gArresteeButton, Arrestee 
Gui, participantGui:Add, Button, x0 y%button4% w%buttonSize% h%buttonSize% gDWIButton, DWI Arrestee
Gui, participantGui:Add, Button, x0 y%button5% w%buttonSize% h%buttonSize% gInfoButton, Info


SetTimer, AFRCheck, 100
return








AFRCheck: ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``
if WinActive("Incident/Arrest Activity Participants")  ;IF THE PARTICIPANTS SCREEN IS ACTIVE ON AFR, SHOW THE GUI
{
     WinGetPos, Xpos, Ypos,Wpos,Hpos, Incident/Arrest Activity Participants
     mainGuiWidth := buttonSize 				; sets width to width of button
     mainGuiHeight := buttonSize * 5 			; sets height to number of buttons
     mainGuiX := Xpos - mainGuiWidth + 10
     mainGuiY := Ypos + (Hpos / 2) - (mainGuiHeight / 2)	
     WinMove, QuickJMS Participants,, mainGuiX, mainGuiY

				
  if(!GuiVisible)
  {
     GuiVisible := true
     goto ShowParticipantsGui  
  }
}
else                                                   ;IF THE PARTICIPANTS SCREEN IS NOT ACTIVE ON AFR, HIDE THE GUI
{
  if(GuiVisible)
  {
     GuiVisible := false
     Gui, participantGui:hide
  }
}
return







RPButton: ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Gui, RPGui:Destroy
selectedProcess := "RPAutoEntry"
Gui, RPGui:Font, s12, Arial
Gui, RPGui:Add, Text, x30 y10 h200 w400, Please paste the Texas Driver's License/ID return in the box below
Gui, RPGui:Add, Edit, vEnteredData x10 y60 h230 w430
Gui, RPGui:Add, Button, x350 y300 w70 h30 gSubmit, Submit
Gui, RPGui:Add, Button, x30 y300 w70 h30 gCancel, Cancel
Gui, RPGui:Show, w450 h350, Reporting Party Entry
return


SuspectButton: ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Gui, SuspectGui:Destroy
selectedProcess := "SuspectAutoEntry"
Gui, SuspectGui:Font, s12, Arial
;Gui, SuspectGui:Add, Text, x30 y10 h200 w400, Please paste the Texas Driver's License/ID return in the box below
Gui, SuspectGui:Add, Text, x30 y10 h200 w280, UNDER CONSTRUCTION: FEATURE COMING SOON
Gui, SuspectGui:Add, Edit, vEnteredData x10 y60 h230 w430
;Gui, SuspectGui:Add, Button, x350 y300 w70 h30 gSubmit, Submit
Gui, SuspectGui:Add, Button, x30 y300 w70 h30 gCancel, Cancel
Gui, SuspectGui:Show, w450 h350, Suspect Entry
return


ArresteeButton: ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Gui, ArresteeGui:Destroy
selectedProcess := "ArresteeAutoEntry"
Gui, ArresteeGui:Font, s12, Arial
Gui, ArresteeGui:Add, Text, x30 y10 h200 w400, Please paste the Texas Driver's License/ID return in the box below
Gui, ArresteeGui:Add, Edit, vEnteredData x10 y60 h230 w430
Gui, ArresteeGui:Add, Button, x350 y300 w70 h30 gSubmit, Submit
Gui, ArresteeGui:Add, Button, x30 y300 w70 h30 gCancel, Cancel
Gui, ArresteeGui:Show, w450 h350, Arrestee Entry
return


DWIButton: ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Gui, DWIGui:Destroy
selectedProcess := "DWIAutoEntry"
Gui, DWIGui:Font, s12, Arial
Gui, DWIGui:Add, Text, x30 y10 h200 w400, Please paste the Texas Driver's License/ID return in the box below
Gui, DWIGui:Add, Edit, vEnteredData x10 y60 h230 w430
Gui, DWIGui:Add, Button, x350 y300 w70 h30 gSubmit, Submit
Gui, DWIGui:Add, Button, x30 y300 w70 h30 gCancel, Cancel
Gui, DWIGui:Show, w450 h350, DWI Entry
return


InfoButton: ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Gui, RPGui:Destroy
selectedProcess := ""
Gui, RPGui:Font, s10, Arial
Gui, RPGui:Add, Text, x30 y10 h200 w400, QuickJMS©, ver 0.0.1, Alpha, 11/7/2022, Automated Field Reporting (AFR) Plugin, Created By: B. Epstein, Written in AutoHotKey  
Gui, RPGui:Add, Button, x30 y300 w70 h30 gCancel, Close
Gui, RPGui:Show, w450 h350, Help
return




Submit:
Gui, Submit
Gui, Destroy
WinActivate, Incident/Arrest Activity Participants
goto parseReturn
return

Cancel:
Gui, Destroy
return





































; ********************************************* METHODS ***************************************

; ctrl 2 - parse return
; ctrl 3 - arrestee jms
; ctrl 4 - dwi arrestee
; ctrl 5 - reporting party


ShowParticipantsGui: ;#############################################################################################################################
;SHOW GUI
Gui, participantGui: +E0x08000000
Gui, participantGui:+AlwaysOnTop -Caption -MaximizeBox -MinimizeBox
Gui, participantGui:Show, x%mainGuiX% y%mainGuiY% w%mainGuiWidth% h%mainGuiHeight% NoActivate, QuickJMS Participants
WinActivate, Incident/Arrest Activity Participants
return








parseReturn:

fullReturn := EnteredData

hay := new Haystack(fullReturn, "") 
hay.processSourceCode()
	temp := hay.parseCode("NAME: ", ",")
	_lname := temp
	
	temp := hay.parseCode(" ","`n")
	_fname := temp
	
	if InStr(_fname, ","){
		tempIndex := InStr(_fname, ",")
		_fname := SubStr(_fname,1,StrLen(_fname)-(StrLen(_fname)-tempIndex+1))
	}


	temp := hay.parseCode("DESCRIPTION: ", "\")
	if InStr(temp, "white")
		_race := "white"
	else if InStr(temp, "black")
		_race := "black"
	else if InStr(temp, "asian")
		_race := "asian"
	else 
		_race := "white"

	temp := hay.parseCode("\", "\")
	_gender := temp
	
	temp := hay.parseCode("\", "\")
	_dob := temp

	temp := hay.parseCode("\", "\")
	_height := temp

	temp := hay.parseCode("\", "\")
	_weight := temp

	temp := hay.parseCode("\", "\")
	_hair := temp

	temp := hay.parseCode("\", "`n")
	_eyes := temp

	temp := hay.parseCode("PHYSICAL ADD: ", " ")
	_addressStreetNum := temp

	temp := hay.parseCode(" ", "`n")
	_addressStreetName := temp

	temp := hay.parseCode("ZIP: ", ",")
	_addressCity := temp

	temp := hay.parseCode(",", ",")
	_addressCounty := temp

	temp := hay.parseCode(",", ",")
	_addressState := temp

	temp := hay.parseCode(",", ",")
	_addressZIP := temp

	temp := hay.parseCode("CARD TYPE: ", " ")
	_IDType := temp

	temp := hay.parseCode("#: ", " ")
	_IDNumber := temp	

	temp := hay.parseCode("CLASS: ", " ")
	_IDClass := temp	



result := _lname . "`n" . _fname . "`n" . _race . "`n" . _gender . "`n" . _dob . "`n" . _height . "`n" . _weight . "`n" . _hair . "`n" . _eyes
result := result . "`n" . _addressStreetNum . "`n" . _addressStreetName  . "`n" . _addressCity  . "`n" . _addressCounty . "`n" . _addressState  . "`n" . _addressZIP
result := result . "`n" . _IDType  . "`n" . _IDNumber . "`n" . _IDClass

processedData := result
if(selectedProcess == "RPAutoEntry")
	goto RPAutoEntry
else if(selectedProcess == "RPAutoEntry")
	goto RPAutoEntry
else if(selectedProcess == "ArresteeAutoEntry")
	goto ArresteeAutoEntry
else if(selectedProcess == "DWIAutoEntry")
	goto DWIAutoEntry

return















































;############################################################

		; JMS

ArresteeAutoEntry:
Send, {Alt down}a{Alt up}
Sleep, 2000
Loop 5,
Send, {Tab}
Send, % _lname
Sleep, 100
Send, {Tab}
Send, % _fname
Sleep, 100
Send, {Tab}
Send, % _mname
Sleep, 100
Send, {Tab}{Tab}
Send, % _race
Sleep, 100
Send, {Tab}
Send, % _gender
Sleep, 100
Send, {Tab}
Send, N
Sleep, 100
Send, {Tab}
sleep, 100
SendRaw, % _dob
Sleep, 300
Send, {Alt down}n{Alt up}
sleep, 100
SendRaw, % _addressStreetNum . " " . _addressStreetName . " " . _addressCity  . " " . _addressState  . " " . _addressZIP
Sleep, 500
Send, {Alt down}x{Alt up}
;--------------
Sleep, 1000
Send, % _height
Sleep, 100
Send, {Tab}
Send, % _weight
Sleep, 100
Send, {Tab}
Send, % _hair
Sleep, 100
Send, {Tab}
Send, % _eyes
Sleep, 100
Loop 3,
Send, {Tab}
Send, UNKNOWN
Sleep, 100
Send, {Alt down}x{Alt up}
;--------------
Sleep, 1000
if (_IDType == "DL"){
	Send, % _IDNumber
	Sleep, 100
	Send, {Tab}
	Send, TX
	Sleep, 100
	Send, {Tab}
	Send, % _IDClass
	Sleep, 100
	Loop 3,
	Send, {Tab}
}else{
	Loop 4,
	Send, {Tab}
	Send, State
	Sleep, 100
	Send, {Tab}
	Send, % _IDNumber
	Sleep, 100
	Send, {Tab}
	Send, TX
	Sleep, 100
	Send, {Tab}{Tab}
}
Send, n
Sleep, 100
Send, {Tab}
Send, u
Sleep, 100
Send, {Tab}
Send, n
Sleep, 100
Send, {Tab}
Send, United S
Sleep, 100
Send, {Tab}
Send, n
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Space}
Sleep, 100
Send, {Alt down}x{Alt up}
;--------------------
Sleep, 1000
Send, Collin
Sleep, 100
Send, {Alt down}x{Alt up}
;--------------------
Sleep, 1000
Send, {Tab}
FormatTime, TimeString,, HHmm
Send, % TimeString
sleep, 100
Send, {Tab}
sleep, 100
Send, o
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Space}
sleep, 100
Send, {Alt down}v{Alt up}
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Space}
Sleep, 4000
Send, {Space}
Sleep, 100
Loop 5, 
Send, {Tab}
Sleep, 100
Send, o
Sleep, 100
Loop 4,
Send, {Tab}
Sleep, 100
Send, n
Sleep, 100
Send, {Tab}{Tab}
Sleep, 100
Send, n
Sleep, 100
Send, {Alt down}o{Alt up}
Sleep, 100
Send, {Alt down}x{Alt up}
Sleep, 500
;-------------------------
Send, {Alt down}x{Alt up}
Sleep, 500
;-------------------------
Send, {Alt down}l{Alt up}
Sleep, 300
Send, {Alt down}x{Alt up}
Sleep, 500
;------------------------
Loop 6,
Send, {Tab}
Sleep, 100
Send, n
Sleep, 300
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
return





























;#############################################################################################

		; DWI ARRESTEE JMS

DWIAutoEntry:
;-------------------------- initial screen
Send, {Alt down}i{Alt up}
Sleep, 2000
Loop 4,
Send, {Tab}
SendRaw, % _lname
Sleep, 100
Send, {Tab}
SendRaw, % _fname
Sleep, 100
Send, {Tab}{Tab}{Tab}
SendRaw, % _race
Sleep, 100
Send, {Tab}
SendRaw, % _gender
Sleep, 100
Send, {Tab}
SendRaw, N
Sleep, 100
Send, {Tab}
sleep, 100
SendRaw, % _dob
Sleep, 300
Send, {Alt down}n{Alt up}
sleep, 100
SendRaw, % _addressStreetNum . " " . _addressStreetName . " " . _addressCity  . " " . _addressState  . " " . _addressZIP
Sleep, 500
Send, {Alt down}x{Alt up}
;-------------- height weight hair eyes place of birth screen
Sleep, 1000
SendRaw, % _height
Sleep, 100
Send, {Tab}
SendRaw, % _weight
Sleep, 100
Send, {Tab}
SendRaw, % _hair
Sleep, 100
Send, {Tab}
SendRaw, % _eyes
Sleep, 100
Loop 3,
Send, {Tab}
SendRaw, UNKNOWN
Sleep, 100
Send, {Alt down}x{Alt up}
;----------------------------- dl # and motor vehicle stop screen
Sleep, 1000
if (_IDType == "DL"){
	SendRaw, % _IDNumber
	Sleep, 100
	Send, {Tab}
	SendRaw, TX
	Sleep, 100
	Send, {Tab}
	SendRaw, % _IDClass
	Sleep, 100
	Loop 3,
	Send, {Tab}
}else{
	Loop 4,
	Send, {Tab}
	SendRaw, State
	Sleep, 100
	Send, {Tab}
	SendRaw, % _IDNumber
	Sleep, 100
	Send, {Tab}
	SendRaw, TX
	Sleep, 100
	Send, {Tab}{Tab}
}
SendRaw, n
Sleep, 100
Send, {Tab}
SendRaw, u
Sleep, 100
Send, {Tab}
SendRaw, n
Sleep, 100
Send, {Tab}
SendRaw, United S
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Space}
Sleep, 100
Send, {Alt down}x{Alt up}
;--------------------  county of arrest screen
Sleep, 1000
SendRaw, Collin
Sleep, 100
Send, {Alt down}x{Alt up}
;-----------------------------charges screen
Sleep, 1000
Send, {Tab}
FormatTime, TimeString,, HHmm
SendRaw, % TimeString
sleep, 100
Send, {Tab}
sleep, 100
SendRaw, o
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Space}
sleep, 100
Send, {Alt down}v{Alt up}
Sleep, 100
Send, {Tab}
Sleep, 100
Send, {Space}
Sleep, 4000
Send, {Space}
Sleep, 100
Loop 5, 
Send, {Tab}
Sleep, 100
SendRaw, o
Sleep, 100
Loop 4,
Send, {Tab}
Sleep, 100
SendRaw, n
Sleep, 100
Send, {Tab}{Tab}
Sleep, 100
SendRaw, n
Sleep, 100
Send, {Alt down}o{Alt up}
Sleep, 100
Send, {Alt down}x{Alt up}
Sleep, 500
;------------------------- emails screen
Send, {Alt down}x{Alt up}
Sleep, 500
;------------------------- location of offense screen
Send, {Alt down}l{Alt up}
Sleep, 300
Send, {Alt down}x{Alt up}
;-------------------------- vehicle in motion screen
Sleep, 1000
SendRaw, Dark
Sleep, 100
Send, {Tab}
SendRaw, Dry
Sleep, 100
Send, {Tab}
SendRaw, Concrete
Sleep, 100
Send, {Tab}
SendRaw, Light
Sleep, 100
Send, {Tab}{Tab}
Sleep, 100
SendRaw, DWI witness Officer
Sleep, 100
Send, {Tab}
Sleep, 200
Send, {Space}
Sleep, 200
Send, {Tab}
Sleep, 300
Send, {Down}{Down}
Sleep, 200
Send, {Space}
Sleep, 100
Send, {Tab}
Sleep, 100
SendRaw, .
Sleep, 100
Send, {Alt down}x{Alt up}
;------------------------------------personal contact
Sleep, 1000
Loop, 4{
Send, {Down}{Space}{Tab}
Sleep, 200
}
Send, {Down}{Down}{Down}{Down}{Space}{Tab}
Sleep, 200
Send, {Down}{Down}{Space}{Tab}
Sleep, 200
Loop, 13
Send, {Down}
Sleep 200
Send, {Space}{Tab}
Sleep, 100
SendRaw, Yes
Sleep, 100
Send, {Tab}
Sleep, 100
SendRaw, Unknown
Sleep, 100
Send, {Tab}
SendRaw, .
Sleep, 100
Send, {Tab}
SendRaw, .
Sleep, 100
Send, {Alt down}x{Alt up}
;---------------------------- HGN Screen
Sleep, 1000
Send, {Tab}
Sleep, 200
Send, {Space}
Sleep 200
Send, {Tab}
Sleep, 200
SendRaw, .
Sleep, 100
Send, {Alt down}x{Alt up}
;------------------------------Walk and Turn Screen
Sleep, 1000
Send, {Space}
Sleep, 200
Send, {Tab}
Sleep, 300
SendRaw, .
Sleep, 100
Send, {Alt down}x{Alt up}
;--------------------------------- One Leg Stand Screen
Sleep, 1000
Send, {Space}{Tab}
Sleep, 100
SendRaw, .
Sleep, 100
Send, {Alt down}x{Alt up}
;---------------------------------- Agreed to blood screen
Sleep, 1000
Send, {Tab}
Sleep, 100
SendRaw, Trainer
Sleep, 100
Send, {Tab}
Sleep, 200
Send, {Space}
Sleep, 100
Send, {Alt down}x{Alt up}
;------------------------------------questions 1 screen
Sleep, 500
Send, {Alt down}x{Alt up}
;------------------------------------questions 2 screen
Sleep, 500
Loop, 15
Send, {Tab}
Sleep, 100
SendRaw, .
Sleep, 100

Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
Send, {Alt down}x{Alt up}
Sleep, 500
return







































;############################################################

		; Reporting Party

RPAutoEntry:
Send, {Alt down}v{Alt up}
Sleep, 2000
SendRaw, r
Sleep, 100
SendRaw, r
Sleep, 100
Send, {Space}
Sleep, 500
Loop 3,
Send, {Tab}
SendRaw, % _lname
Sleep, 100
Send, {Tab}
SendRaw, % _fname
Sleep, 100
Send, {Tab}
SendRaw, % _mname
Sleep, 100
Send, {Tab}{Tab}
SendRaw, % _race
Sleep, 100
Send, {Tab}
SendRaw, % _gender
Sleep, 100
Send, {Tab}
SendRaw, N
Sleep, 100
Send, {Tab}
sleep, 100
SendRaw, % _dob
Sleep, 300
Send, {Alt down}n{Alt up}
sleep, 100
SendRaw, % _addressStreetNum . " " . _addressStreetName . " " . _addressCity  . " " . _addressState  . " " . _addressZIP
Sleep, 500
Send, {Alt down}x{Alt up}
;--------------
Sleep, 1000
SendRaw, % _height
Sleep, 100
Send, {Tab}{Tab}
Sleep, 100
SendRaw, % _weight
Sleep, 100
Send, {Tab}{Tab}
Sleep, 100
SendRaw, % _hair
Sleep, 100
Send, {Tab}
Sleep, 100
SendRaw, % _eyes
Sleep, 100
Send, {Alt down}x{Alt up}
;--------------
Sleep, 1000
if (_IDType == "DL"){
	SendRaw, % _IDNumber
	Sleep, 100
	Send, {Tab}
	SendRaw, TX
	Sleep, 100
	Send, {Tab}
	SendRaw, % _IDClass
	Sleep, 100
}else{
	Send, {Tab}
	Sleep, 100
	Send, {Tab}
	Sleep, 100
	Send, {Tab}
	Sleep, 100
	Send, {Tab}
	Sleep, 500
	SendRaw, State
	Sleep, 100
	Send, {Tab}
	Sleep, 100
	SendRaw, % _IDNumber
	Sleep, 100
	Send, {Tab}
	Sleep, 100
	SendRaw, TX
}
Sleep, 800
Send, {Alt down}x{Alt up}
Sleep, 800
Send, {Alt down}x{Alt up}
Sleep, 800
Send, {Alt down}x{Alt up}
Sleep, 800
Send, {Alt down}x{Alt up}
Sleep, 800
Send, {Alt down}x{Alt up}
Sleep, 800
Send, {Alt down}x{Alt up}
return




































;#############################################




#IfWinActive
ExitApp
*ESC::ExitApp






;=============================================== old hotkey for parsing NCIC return
send, {Ctrl down}a{Ctrl up}
sleep, 100
send, {Ctrl down}c{Ctrl up}
sleep, 100
fullReturn := clipboard
msgbox, % fullReturn

hay := new Haystack(fullReturn, "") 
hay.processSourceCode()
	temp := hay.parseCode("NAME: ", ",")
	_lname := temp
	
	temp := hay.parseCode(" ","`r`n")
	_fname := temp
	
	if InStr(_fname, ","){
		tempIndex := InStr(_fname, ",")
		_fname := SubStr(_fname,1,StrLen(_fname)-(StrLen(_fname)-tempIndex+1))
	}


	temp := hay.parseCode("DESCRIPTION: ", "\")
	if InStr(temp, "white")
		_race := "white"
	else if InStr(temp, "black")
		_race := "black"
	else if InStr(temp, "asian")
		_race := "asian"
	else 
		_race := "white"

	temp := hay.parseCode("\", "\")
	_gender := temp
	
	temp := hay.parseCode("\", "\")
	_dob := temp

	temp := hay.parseCode("\", "\")
	_height := temp

	temp := hay.parseCode("\", "\")
	_weight := temp

	temp := hay.parseCode("\", "\")
	_hair := temp

	temp := hay.parseCode("\", "`r`n")
	_eyes := temp

	temp := hay.parseCode("PHYSICAL ADD: ", " ")
	_addressStreetNum := temp

	temp := hay.parseCode(" ", "`r`n")
	_addressStreetName := temp

	temp := hay.parseCode("ZIP: ", ",")
	_addressCity := temp

	temp := hay.parseCode(",", ",")
	_addressCounty := temp

	temp := hay.parseCode(",", ",")
	_addressState := temp

	temp := hay.parseCode(",", ",")
	_addressZIP := temp

	temp := hay.parseCode("CARD TYPE: ", " ")
	_IDType := temp

	temp := hay.parseCode("#: ", " ")
	_IDNumber := temp	

	temp := hay.parseCode("CLASS: ", " ")
	_IDClass := temp	



result := _lname . "`n" . _fname . "`n" . _race . "`n" . _gender . "`n" . _dob . "`n" . _height . "`n" . _weight . "`n" . _hair . "`n" . _eyes
result := result . "`n" . _addressStreetNum . "`n" . _addressStreetName  . "`n" . _addressCity  . "`n" . _addressCounty . "`n" . _addressState  . "`n" . _addressZIP
result := result . "`n" . _IDType  . "`n" . _IDNumber . "`n" . _IDClass
clipboard := result
msgbox, % result
return










Class Haystack
{
	rawCode := ""
	filteredCode := ""
	currentCode := ""
	currentIndex := 0
	filterAtThisWord := ""


	__New(_raw, _filterWord)
	{
		this.rawCode := _raw
		this.filterAtThisWord := _filterWord
	}


	processSourceCode()
	{
		needle1 := this.filterAtThisWord          ;html before the string youre looking for
		needle1index := InStr(this.rawCode, needle1)      ;gets the index of the above needle 1 
				
		this.filteredCode := SubStr(this.rawCode, needle1index)   ;grabs the string youre looking for
		this.currentCode := this.filteredCode
	}


	updateToNewIndex()
	{
		this.currentCode := SubStr(this.currentCode, this.currentIndex)   ;grabs the string youre looking for
	}

	
	parseCode(_needle1,_needle2)
	{
		
		needle1 := _needle1
		needle2 := _needle2
	


		needle1index := InStr(this.currentCode, needle1)      ;gets the index of the above needle 1 
		needle1index += StrLen(needle1)				    ;moves the index to the end of the above needle 1 string


		tempCode := SubStr(this.currentCode, needle1index)  ;temporaily shortens the source code to the end of needle 1 
	

		needle2index := InStr(tempCode, needle2)		    ;gets the index of needle 2	
		tempLength := needle2index - 1			            ;gets the length between end of needle1index and needle2index

		result := SubStr(this.currentCode, needle1index, tempLength)   ;grabs the string youre looking for
		this.currentIndex := needle1index + tempLength
		this.updateToNewIndex()
		
		return result       ;returns the string you searched for	
	}

	parseCodeFromZero(_needle2)
	{
		
		needle2 := _needle2
	
		tempCode := SubStr(this.currentCode, 1)  ;temporaily shortens the source code to the end of needle 1 
	

		needle2index := InStr(tempCode, needle2)		    ;gets the index of needle 2	
		tempLength := needle2index - 1			            ;gets the length between end of needle1index and needle2index

		result := SubStr(this.currentCode, 1, tempLength)   ;grabs the string youre looking for
		this.currentIndex := 1 + tempLength
		this.updateToNewIndex()
		
		return result       ;returns the string you searched for	
	}



	getFilterWord()
	{
		return this.filterAtThisWord
	}

	getRaw()
	{
		return this.rawCode
	}



	getCurrentCode()
	{
		return this.currentCode
	}

}
