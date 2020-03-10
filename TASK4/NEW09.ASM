.186
.model tiny
.code
org 100h

locals	@@

public	Old09
public	New09

extrn	al2hex	:proc
extrn	framedr	:proc
extrn 	EndLabel

;=================================================
; New int 09h that writes scancode in hex of the pushed key in frame
;=================================================

New09	proc
		push	ax bx cx dx di si es
		mov	ax, 0b800h
		mov	es, ax
		mov	di, (8*80+30)*2
		mov	cx, 20
		mov	dx, 5
		call	framedr

		in	al, 60h
		cmp	al, 21h
		jne	@@toHex
		mov	di, (6*80+28)*2
		mov	cx, 24
		mov	dx, 9
		call	framedr

@@toHex:	call	Al2Hex
		mov 	di, (10*80+40)*2
		mov	ah, 4eh
		mov	al, dh
		stosw
		mov	al, dl
		stosw

		in	al, 61h
		mov	ah, al
		or	al, 80h
		out	61h, al
		xchg	al, ah
		out	61h, al

		mov	al, 20h
		out	20h, al

		pop	es si di dx cx bx ax
	
		db	0eah
Old09		dw 	0
		dw 	0

		endp

end
