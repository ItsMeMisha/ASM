.186
.model tiny

.code

org	100h

public	setclr

;=================================================
; Sets black and green color mod
;=================================================

setclr		proc

		pusha
		push	es

		push	0b800h
		pop	es

		mov	bx, 1h

		mov	al, 002h
		mov	cx, 4000d

@@FULLSCREEN:	mov	byte ptr es:[bx], al
		add	bx, 2
		loop	@@FULLSCREEN

		pop	es
		popa

		ret
		endp

end