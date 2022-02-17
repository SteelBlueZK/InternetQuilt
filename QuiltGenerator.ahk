﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Screen

;================================================= global variables =======================================

QuiltComplexity :=	25
spacing :=		10

;================================================= auto execute ===========================================

MsgBox, "For now, open paint editor. esc to exit or wait to completion."

clicksdisable := 1
ToolTip, click somewhere
KeyWait, LButton, D
MouseGetPos, topleftx, toplefty
KeyWait, LButton, U
ToolTip,  click somewhere else
KeyWait, LButton, D
MouseGetPos, botrightx, botrighty
KeyWait, LButton, U
ToolTip
clicksdisable := 0
MsgBox, X1,Y1: %topleftx%,%toplefty% `nX2,Y2: %botrightx%,%botrighty% `nWill paint quilt %QuiltComplexity% times. Estimated time is %QuiltComplexity%*patchworks*2.5 seconds.

RightClickArray(X1,Y1,X2,Y2,S) {
	; range 1 is top left, range 2 is bottom right.
	XF := (X2-X1) / S
	YF := (Y2-Y1) / S
	Loop
	{
		if(A_Index>YF)
			break
		Yloop:= A_Index - 1
		Loop
		{
			if(A_Index>XF)
				break
			Xlast := X1+(S*(A_Index-1))
			Ylast := Y1+(S*Yloop)
			Click, %Xlast%, %Ylast%, Left
			sleep 7
		}
	}
}

Loop %QuiltComplexity%
{
	Loop 
	{
		C := A_Index-1
		XI := Floor((botrightx-topleftx)/(12*spacing))
		YI := Floor((botrighty-toplefty)/(12*spacing))
		xiteration := Mod(C, XI)
		yiteration := Mod(Floor(C/XI), (YI))
		Random, xrand , 0, spacing
		Random, yrand , 0, spacing
		X3 := topleftx + xrand + 12*spacing*xiteration
		Y3 := toplefty + yrand + 12*spacing*yiteration
		RightClickArray(X3,Y3,X3+12*spacing,Y3+12*spacing,spacing)
		If (A_Index = XI*YI)
			break
	}
}

MsgBox, Script complete
ExitApp

;=========================== End of intended autoexecute ===================================

clicksdisable := 0

#if clicksdisable

LButton::
return

RButton::
return

#if

Esc::ExitApp
return
