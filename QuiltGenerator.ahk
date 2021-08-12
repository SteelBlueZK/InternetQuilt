#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Screen

QuiltComplexity :=		25			; special number, needs camera set up special.
topleftx :=				635
toplefty :=				400
botrightx :=			1300
botrighty :=			800
spacing :=				10






RightClickArray(X1,Y1,X2,Y2,S) {
	; range 1 is top left, range 2 is bottom right.
	XF := (X2-X1) / S
	YF := (Y2-Y1) / S
	Loop
	{
		if(A_Index>YF)
			break
		Yloop:= A_Index 
		Loop
		{
			if(A_Index>XF)
				break
			Xlast := X1+(S*A_Index)
			Ylast := Y1+(S*Yloop)
			Click, %Xlast%, %Ylast%, Left
			sleep 7
		}
	}
}



MsgBox, "For now, open paint editor. esc to exit or wait to completion."

ToolTip, click somewhere
KeyWait, LButton, D
MouseGetPos, topleftx, toplefty
KeyWait, LButton, U
ToolTip,  click somewhere else
KeyWait, LButton, D
MouseGetPos, botrightx, botrighty
KeyWait, LButton, U
ToolTip
MsgBox, X1,Y1: %topleftx%,%toplefty% `nX2,Y2: %botrightx%,%botrighty% `nWill paint quilt %QuiltComplexity% times.

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

Esc::ExitApp
return
