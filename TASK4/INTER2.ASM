.186
.model tiny
.code
org 100h

extrn	Al2Hex	:proc
extrn	framedr	:proc
extrn 	EndLabel
Start:		xor	ax, ax
		mov	es, ax

		cli
		mov	bx, ax
		mov	ax, word ptr es:[bx]
		mov	Old09, ax
		mov	ax, word ptr es:[bx+2]
		mov	Old09+2, ax

		mov	word ptr es:[bx], offset New09
		mov	ax, cs
		mov 	word ptr es:[bx+2], ax
		sti

		mov	ax, 3100h
		mov	dx, offset EndLabel
		shr 	dx, 4
		inc	dx
		int 	21h

New09	proc
		push	ax bx cx dx di si es
		mov	ax, 0b800h
		mov	es, ax
		mov	di, (8*80+30)*2
		mov	cx, 20
		mov	dx, 5
		call	framedr
		in	al, 60h
		call	Al2Hex
		mov 	di, (10*80+40)*2
		mov	ah, 4eh
		mov	al, dh
		stosw
		mov	al, dl
		stosw

		mov	dl, al
		in	al, 61h
		mov	ah, al
		or	al, 80h
		out	61h, al
		xchg	al, ah
		out	61h, al

		mov	al, 20h
		out	20h, al

		pop	es si di dx cx bx ax
	
		db	0eah
Old09		dw 	0
		dw 	0

		endp

end	Start
