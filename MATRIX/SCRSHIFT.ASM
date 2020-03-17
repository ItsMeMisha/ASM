.186
.model tiny

locals	@@

.code
org	100h

public	scrsft

;=================================================
; Moves all lines of the screen down (last line to the top)
;=================================================

scrsft		proc

		pusha
		push	es di
		mov	ax, 0b800h
		mov	es, ax

		mov	cx, 79d
		mov	bx, 0h
		mov	di, 80*24*2

@@FILLBUF:	mov	al, byte ptr es:[di]
		mov	cs:LASTLINE[bx], al
		add	di, 2
		inc	bx
		
		loop	@@FILLBUF

		mov	bx, 80*24*2
@@DOSHIFT:	sub	bx, 2
		mov	al, byte ptr es:[bx]
		mov	byte ptr es:[bx+160], al
		cmp	bx, 0h
		ja	@@DOSHIFT

		mov	di, 0h
		mov	bx, 0h
		mov	cx, 79d

@@EMPTYBUF:	mov	al, cs:LASTLINE[bx]
		mov	byte ptr es:[di], al
		add	di, 2
		inc	bx
		loop	@@EMPTYBUF

		pop	di es
		popa

		ret
		endp

LASTLINE	db 82d dup  (?)


end
