.186
.model tiny
.code
org 	100h


extrn		rplInt	:proc

extrn		Old28
extrn		New28	:proc

extrn		Old09
extrn		New09	:proc

extrn		Old08
extrn		New08	:proc

extrn		EndLabel

public		BufBeg
public		BufEnd
public		BUF
public		COUNT
public		filespec

Start:		mov	COUNT, 0

		mov	cx, 28h
		mov	di, offset Old28
		mov	si, offset New28

		call	rplInt

		mov	cx, 09h
		mov	di, offset Old09
		mov	si, offset New09

		call	rplInt

		mov	cx, 08h
		mov	di, offset Old08
		mov	si, offset New08

		call	rplInt

		mov	ax, 3100h
		mov	dx, offset EndLabel
		shr	dx, 4
		inc	dx
		int	21h

.data

filespec	db 's:\doc\tasks\task5\log.txt', 0h

BufBeg		db 	0h
BufEnd		db 	0h

BUF		db 260d dup(0)	;BUF[0..255]

COUNT		db 	0h
end	Start
