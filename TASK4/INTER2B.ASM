.186
.model tiny
.code
org 100h

extrn	rplInt	:proc

extrn	Old09
extrn	New09	:proc
extrn 	EndLabel
Start:		xor	ax, ax
		mov	es, ax
		mov	cx, 9h
		mov	di, offset Old09
		mov	si, offset New09

		call	rplInt

		mov	ax, 3100h
		mov	dx, offset EndLabel
		shr 	dx, 4
		inc	dx
		int 	21h

end	Start
