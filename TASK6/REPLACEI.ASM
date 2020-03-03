.186
.model tiny
.code
org 100h

;=================================================
; Replace interuption
; Entry:DI: address where to save old interuption
;	SI: address where is located new interuption
;	CS: segment where to save
;	CX: number of interuption
; Destr:AX, BX, ES
;=================================================

public		rplInt

rplInt		proc

		cli
		
		mov	ax, 0h
		mov	es, ax

		mov	bx, cx
		shl	bx, 2

		mov	ax, word ptr es:[bx]
		mov	word ptr cs:[di], ax
		mov	ax, word ptr es:[bx+2]
		mov	word ptr cs:[di+2], ax

		mov	word ptr es:[bx], si
		mov	ax, cs
		mov	word ptr es:[bx+2], ax
	
		sti
		ret
rplInt	endp

end