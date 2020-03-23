.186
.model tiny

.code 
locals @@

org 	100h

extrn	Al2Hex	:proc

public	convregs

;=================================================
; Converts registers in hex tp array
; Entry:AX, BX, CX, DX - registers
; Destr: none
;=================================================

convregs	proc

		pusha
		push	es ds di si

		mov	cs:REGS[0], ax
		mov	cs:REGS[1], bx
		mov	cs:REGS[2], cx
		mov	cs:REGS[3], dx

		mov	bx, 4

@@convert:	mov	ax, REGS[bx-1]
		call	Al2Hex
		xchg	ah, al
		call	Al2Hex
		xchg	ah, al
		mov	REGS[bx-1], dh
		dec	bx
		cmp	bx, 0h
		ja	@@convert

		pop	si di ds es
		popa

		endp

public		showregs

;=================================================
; Shows regs from REGS array
; Entry:REGS - array
; 
;=================================================

REGS dw 00h, 00h, 00h, 00h

end