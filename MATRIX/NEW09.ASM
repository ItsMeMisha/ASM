.186
.model tiny
.code
org 100h

locals	@@

public	Old09
public	New09
public	MATRIX

extrn	framedr	:proc
extrn	printl	:proc

extrn 	EndLabel

;=================================================
; New int 09h that turn matrix on and off
;=================================================

New09		proc

		push	ax bx cx dx di si es

		in	al, 60h
		cmp	cs:MATRIX, 0
		jne	cs:@@GOOUT

		cmp	al, 3ah		;capsLock
		jne	@@NotYet

		mov	cs:MATRIX, 1

		mov	di, (80*4+14)*2
		mov	cx, 52d
		mov	dx, 9d
		call	framedr

		mov	si, offset cs:WAKEUP
		mov	di, (80*9+33)*2
		push	cs
		pop	ds
		call	printl
		
		mov	cs:MATRIX, 1
		jmp	cs:@@NotYet

@@GOOUT:	call	checkRed
		cmp	cs:MATRIX, 1
		je	cs:@@NotYet

@@NotYet:	in	al, 61h
		mov	ah, al
		or	al, 80h
		out	61h, al
		xchg	al, ah
		out	61h, al

		pop	es si di dx cx bx ax
	
		db	0eah
Old09		dw 	0
		dw 	0

		iret
		endp

;=================================================
; Checks if typed 'red'
; Entry: AL - typed letter
; Destr: BX
;=================================================

checkRed	proc

		mov	bl, cs:CURLETTER
		mov	bh, 0h
		cmp	al, cs:RED[bx]
		jne	cs:@@WRONGLET

		inc	cs:CURLETTER
		cmp	cs:CURLETTER, 6h
		jne	cs:@@ENDCHECK

		mov	cs:MATRIX, 0h

@@WRONGLET:	mov	cs:CURLETTER, 0h

@@ENDCHECK:	ret
		endp

RED		db	13h, 93h, 12h, 92h, 20h, 0A0h	;'red' in scancodes
CURLETTER	db	0h

MATRIX		db	0h

INTBUF		dw	0
		dw	0

WAKEUP		db 	'WAKE UP, NEO', 0h

end
