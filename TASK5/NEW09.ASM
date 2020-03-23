.186
.model tiny
.code
org 	100h


public		Old09
public		New09

extrn		BufBeg	:byte
extrn		BufEnd	:byte
extrn		BUF	:byte
extrn		COUNT	:byte

;=================================================
; New int 09h that should read pushed keys and write them to BUF
;=================================================

New09		proc

		push	ax ds di bx es

		pushf
		call	dword ptr cs:[Old09]
		popf

		pushf
;		in	al, 60h

		mov	ax, 00h
		int	16h

		mov	bl, cs:BufEnd
		mov	bh, 00h
		mov	cs:BUF+bx, al
;		inc	COUNT
		inc	cs:BufEnd

		popf

		pop	es bx di ds ax

;		db 	0eah
;Old09		dw	0h
;		dw	0h

		in	al, 61h
		mov	ah, al
		or	al, 80h	
		out	61h, al
		xchg	ah, al
		out	61h, al
	
		mov	al, 20h
		out	20h, al

		iret
		endp

.data

Old09		dw	0
		dw	0
end