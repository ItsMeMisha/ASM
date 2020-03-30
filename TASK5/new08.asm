.186
.model 	tiny

locals	@@
org	100h

.code

extrn	MATRIX
extrn	setclr	:proc
extrn	oneiter	:proc
extrn	scrsft	:proc

public	Old08
public	New08

CURLINE		db 	0h

New08		proc

		pushf
		pusha
		push	es si di ds

		cmp	cs:MATRIX, 0h
		je	cs:@@CONTINUE

		call	setclr

		mov	al, cs:CURLINE
		mov	ah, 0h
		call	oneiter
		inc	al
		call	oneiter

		call	scrsft

		add	cs:CURLINE, 2
		cmp	cs:CURLINE, 78h
		jbe	cs:@@CONTINUE
		mov	cs:CURLINE, 0h
		
@@CONTINUE:	pop	ds di si es
		popa

	        call 	dword ptr cs:[Old08]        
		iret
		endp

Old08   	dw	0
        	dw	0
        
end
