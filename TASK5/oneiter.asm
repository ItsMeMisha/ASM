.186
.model tiny

locals 	@@

.code
org	100h

public	oneiter

;=================================================
; Moves spaces to upper line and significant chars to down
; Entry: AX number of the upper line
; Destr: AX, BX, CX, ES, AX
;=================================================

oneiter		proc

		pusha
		push 	es ds si di

		push	0b800h
		pop	es

		mov	bx, ax
		shl	bx, 1	 

		mov	cx, 23d

@@xchange:	mov	al, byte ptr es:[bx+160]
		cmp	al,  ' '
		je	cs:@@chng

		cmp	al, 00h
		jne	cs:@@LOOP

@@chng:		mov	al, byte ptr es:[bx+160]
		mov	ah, byte ptr es:[bx]
		mov	byte ptr es:[bx], al
		mov	byte ptr es:[bx+160], ah

@@LOOP:		add	bx, 160h

		loop	cs:@@xchange

		pop di si ds es
		popa

		ret
		endp
end