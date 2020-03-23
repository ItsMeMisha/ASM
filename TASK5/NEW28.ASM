.186
.model tiny
.code
org 	100h
locals @@

extrn		BufBeg	:byte
extrn		BufEnd	:byte
extrn		BUF	:byte
extrn		COUNT	:byte
extrn		filespec:byte

public		Old28
public		New28

;=================================================
; New int 28h prints COUNT bytes from BUF to filespec and set COUNT to 0
;=================================================


New28		proc

		pushf
		push	ax dx ds bx cx di si es


		mov	cl, cs:BufEnd
		sub	cl, cs:BufBeg
		cmp	cl, 0
		jbe	@@End28

		mov	dx, offset cs:filespec
		push	cs
		pop	ds

		mov	ax, 3d02h
		int 	21h
		mov	bx, ax

		jnc	@@cont
		mov	dl, al
		mov	ax, 0200h
		int	21h
		jmp	@@End28

@@cont:		mov	ax, 4202h
		mov	cx, 0
		mov	dx, 0
		int 	21h

		mov	cl, cs:BufEnd
		sub	cl, cs:BufBeg
		mov	ch, 00h
		mov	dx, offset BUF
		add	dl, cs:BufBeg 

		mov	ax, 4000h
		int	21h

;		mov	COUNT, 0
		mov	al, cs:BufEnd
		mov	cs:BufBeg, al

		mov	ax, 3e00h
		int 	21h

@@End28:	pop	es si di cx bx ds dx ax

;		mov	al, 20h
;		out	20h, al

		popf
		iret
		endp

.data

Old28		dw	0
		dw	0
end