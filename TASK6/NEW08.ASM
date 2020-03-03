.186
.model tiny
.code
org	100h

extrn	sortfwd	:proc
extrn	sortbkd	:proc
extrn	printl	:proc

public	New08
public	Old08

;=================================================
; New int 08h sort ARR in different orders 
;=================================================

New08		proc
		
		pushf
		pusha
		push	es si di ds

		mov	ax, cs
		mov	es, ax

		mov	di, offset ARR
		mov	cx, 8d

		call	sortfwd

		mov	ax, cs
		mov	ds, ax

		mov	si, offset ARR
		mov	di, 2d
		
		call	printl

		mov	ax, cs
		mov	es, ax

		mov	cx, 0ffffh
pause:		
		loop	pause

		mov	di, offset ARR
		mov	cx, 8d

		call	sortbkd

		mov	ax, cs
		mov	ds, ax

		mov	si, offset ARR
		mov	di, 162d

		call	printl

		pop	ds di si es
		popa
		popf

		db	0eah
Old08		dw	0
		dw	0

		iret
endp

.data

ARR	db  	41h, 47h, 46h, 45h, 44h, 43h, 42h, 48h
	db 	0

end