*-----------------------------------------------------------
* Program    : Microprocessor Project, 
* Written by :Abdul Al-Faraj & Ally Malima 
* Date       :08/01/2012
* Description:The purpse of this program is to keep polling for a signal from a switch, once the switch is on,
*             The system starts to fade the LED from Red to Green, if the swithc is off, 
*             The system holds the current color of the LED.
*-----------------------------------------------------------
	dc.l	0
	dc.l	8
					
START:				; first instruction of program

	MOVE.B	#1, $0000	; initally set the LED to Red
REST
	MOVE.W	#1000,D4	; Set Counter for red
	MOVE.W	#1,D5		; Set Counter for green

SWITCH	MOVE.B 	$2000,D6        ; Check for the switch.
	AND.B	#$01,D6
	BNE	SWITCH
	
	
	
FADE	                        ; to fade from Red to Green
	MOVE.B	#1, $0000	; put the LED Red
	
	MOVE.W	D4, D2		; Set the new timing for Red
	MOVE.W	D5, D3		; Set the new timing for Green
	

RED	SUB.W	#1, D2		;Countdown -Red 
	BNE	RED
	
	MOVE.B	#0, $0000	;to put the LED green
	
GREEN	SUB.W	#1, D3		;Countdown -Green
	BNE	GREEN

	MOVE.B 	$2000,D6	;Check the switch
	AND.B	#$01,D6
	BNE	FADE            ; if the switch isn't press
	                        ; hold the current LED colour, else
	ADD.W	#1,D5           ; increment Green Length 
	SUB.W	#1,D4           ; decrement red length
	CMP.W	#0,D4           ; check if the LED is currently FULLY green
	BNE	FADE		; Go back to fade if the decrementing of D4 isn't complete		
		
	MOVE.W	#1,D4		; Set Counter for red
	MOVE.W	#1000,D5	; Set Counter for green

                                
	
FADE2	                        ; FADE2, is to fade from red to green
	MOVE.W	D4, D2		; TO set counter for red
	MOVE.W	D5, D3		; TO set counter for green	
	MOVE.B	#0, $0000	; To put the LED green
	
GREEN2	SUB.W	#1, D3		;Countdown -Green
	BNE	GREEN2


	MOVE.B	#1, $0000	; put the LED Red
	
RED2	SUB.W	#1, D2		;Countdown -Green
	BNE	RED2
	


	MOVE.B 	$2000,D6       ;Check switch
	AND.B	#$01,D6        ; if not pressed,
	BNE	FADE2          ; Hold color
	                       ; Else
	ADD.W	#1,D4          ; increment Red Length 
	SUB.W	#1,D5          ; decrement Green Length 
	CMP.W	#0,D5          ; check if the LED completly RED
	BNE	FADE2
	
	BRA 	FADE           ; To return to the first state.

	END	START		; last line of source, End Program












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
