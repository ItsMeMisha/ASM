.186
.model tiny
.code
org	100h

extrn	New08	:proc
extrn	Old08

extrn	EndLabel

extrn	rplInt	:proc

Start:		mov	cx, 08h
		mov	di, offset Old08
		mov	si, offset New08

		call	rplInt
	
		mov	ax, 3100h
		mov	dx, offset EndLabel
		shr	dx, 4
		inc	dx
		int	21h

end	Start