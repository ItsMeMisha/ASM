.model tiny
.code
org 100h
locals @@

;=================================================
; Returns two ASCII codes: BH - high digit, BL - low digit
; Entry:AL - number to converse
; Exit:	DH, DL - two digits
;=================================================

public	Al2Hex

Al2Hex	proc

		push	ax
		mov	dx, 0f00fh
		and	dl, al
		and	dh, al
		shr	dh, 4

		mov	al, dl
		call	Dgt2Chr
		mov	dl, ah
	
		mov	al, dh
		call	Dgt2Chr
		mov	dh, ah	

		pop	ax
		ret
Al2Hex	endp

;=================================================
; Turns low 4 bits of al to ascii code
; Entry:AL - digit to converse
; Exit:	AH - ascii code
;=================================================

public Dgt2Chr

Dgt2Chr proc

		mov	ah, al
		cmp	ah, 09h
		jbe	@@LESS
		add	ah, 07h
	
@@LESS:		add	ah, 30h
		ret

Dgt2Chr	endp

end
