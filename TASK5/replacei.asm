.186
.model tiny
.code
org 100h

;=================================================
; Replace interuption
; Entry:DI: address where to save old interuption
;	SI: address where is located new interuption
;	CS: segment where to save
;	AL: number of interuption
; Destr:AX, BX, ES
;=================================================

public		rplInt

rplInt		proc

		mov	ah, 35h
		int	21h
		mov	word ptr cs:[di], bx
		mov	word ptr cs:[di+2], es

		push	cs
		pop	ds
		mov	dx, si
		mov	ah, 25h
		int	21h

		ret
rplInt	endp

end