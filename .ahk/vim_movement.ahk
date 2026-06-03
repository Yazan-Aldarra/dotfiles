#+n:: Send "{Down}"
#+p:: Send "{Up}"
#+e:: Send "{Right}"
#+b:: Send "{Left}"

#HotIf WinActive("ahk_exe explorer.exe")

!j:: Send "{Down}"
!k:: Send "{Up}"
!l:: Send "{Right}"
!h:: Send "{Left}"
+!d:: Send "{Delete}"
!y:: Send "^c"
!p:: Send "^v"
!r:: Send "{F2}"
!m:: Send "^x"

#HotIf

#HotIf WinActive("ahk_exe Microsoft.CmdPal.UI.exe")

!j:: Send "{Down}"
!k:: Send "{Up}"
!l:: Send "{Right}"
!h:: Send "{Left}"

#HotIf

#HotIf WinActive("ahk_exe chrome.exe")

!h:: Send "{Left}"
!j:: Send "{Down}"
!k:: Send "{Up}"
!l:: Send "{Right}"

!+h:: Send "^{Home}"
!+j:: Send "^{PgUp}"
!+k:: Send "^{PgDn}"
!+l:: Send "^{End}"

!1:: Send("^1")
!2:: Send("^2")
!3:: Send("^3")
!4:: Send("^4")
!5:: Send("^5")
!6:: Send("^6")
!7:: Send("^7")
!8:: Send("^8")
!9:: Send("^9")

#HotIf

;  NOTE: If the active application matches the Windows title of any strings below

; WinActiveMatch() {
; 	activeTitle := WinGetTitle("A")
;
; 	; List of strings to match (partial matches work)
; 	matchList := [
; 		"New Tab - Google Chrome",
; 		"Settings - Google Chrome",
; 		"History - Google Chrome",
; 		"Bookmarks - Google Chrome",
; 		"Downloads - Google Chrome",
; 		"Extensions - Google Chrome",
; 		"Passwords - Google Chrome",
; 		"Privacy and security - Google Chrome",
; 		"Search engine - Google Chrome",
; 		"Appearance - Google Chrome",
; 		"On startup - Google Chrome",
; 		"Address bar and search - Google Chrome",
; 		"Languages - Google Chrome",
; 		"Downloads - Google Chrome",
; 		"Accessibility - Google Chrome",
; 		"System - Google Chrome",
; 		"Reset and clean up - Google Chrome",
; 		"Performance - Google Chrome",
; 		"Memory saver - Google Chrome",
; 		"About Chrome - Google Chrome",
; 		"chrome://flags - Google Chrome",
; 		"chrome://version - Google Chrome",
; 		"chrome://extensions - Google Chrome",
; 		"chrome://history - Google Chrome",
; 		"chrome://bookmarks - Google Chrome",
; 		"chrome://downloads - Google Chrome",
; 		"chrome://password-manager - Google Chrome",
; 		"chrome://settings/content - Google Chrome",
; 		"chrome://settings/privacy - Google Chrome",
; 		"chrome://settings/security - Google Chrome",
; 		"chrome://settings/syncSetup - Google Chrome",
; 		"chrome://settings/people - Google Chrome",
; 		"chrome://settings/addresses - Google Chrome",
; 		"chrome://settings/payments - Google Chrome",
; 		"chrome://settings/searchEngines - Google Chrome",
; 		"chrome://settings/accessibility - Google Chrome",
; 		"chrome://settings/system - Google Chrome",
; 		"chrome://settings/reset - Google Chrome",
; 		"chrome://settings/help - Google Chrome",
; 		"chrome://whats-new - Google Chrome",
; 		"chrome://new-tab-page - Google Chrome",
; 		"chrome://bookmarks/ - Google Chrome",
; 		"chrome://history/ - Google Chrome",
; 		"chrome://downloads/ - Google Chrome",
; 		"chrome://password-manager/passwords - Google Chrome",
; 		"chrome://password-manager/checkup - Google Chrome",
; 		"chrome://password-manager/settings - Google Chrome"
; 	]
;
; 	for index, match in matchList {
; 		if InStr(activeTitle, match) {
; 			return true
; 		}
; 	}
; 	return false
; }
