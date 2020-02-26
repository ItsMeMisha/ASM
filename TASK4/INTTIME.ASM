.186
.model tiny
.code
org 100h

Start:	xor	ax, ax
	mov	es, ax
	
	cli
	mov	bx, 8*4h

	mov	word ptr es:[bx], offset New08
	mov	ax, cs
	mov 	word ptr es:[bx+2], ax
	sti

	mov	ax, 3100h
	mov	dx, offset EndLabel
	shr 	dx, 4
	inc	dx
	int 	21h

New08	proc
	push	ax di es

	push 	0b800h
	pop	es
	mov	di, 0
	pop 	ax
	stosw
	push	ax

	mov	al, 20h
	out	20h, al

	pop	es di ax
	iret
	endp

EndLabel:
end	Start