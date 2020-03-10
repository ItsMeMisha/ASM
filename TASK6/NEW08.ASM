.186
.model tiny
.code
org	100h
locals	@@

extrn	sortfwd	:proc
extrn	sortbkd	:proc
extrn	printl	:proc
extrn	framedr	:proc

public	New08
public	Old08

;=================================================
; New int 08h sort ARR in different orders 
;=================================================

New08		proc
		
		pushf
		pusha
		push	es si di ds

		mov	di, 0d
		mov	cx, 10d
		mov	dx, 4d
		call	framedr

		mov	ax, cs
		mov	es, ax

		mov	di, offset ARR
		mov	cx, 8d

		call	sortfwd
		
		mov	ax, cs
		mov	ds, ax

		mov	si, offset ARR
		mov	di, 324d
		
		call	printl

		mov	cx, 0ffffh
@@pause:		
		loop	@@pause

		push	cs
		pop	es

		mov	di, offset ARR
		mov	cx, 8d

		call	sortbkd

		mov	ax, cs
		mov	ds, ax

		mov	si, offset ARR
		mov	di, 484d

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

ARR	db  	41h, 47h, 46h, 45h, 44h, 43h, 42h, 48h, 0h

end