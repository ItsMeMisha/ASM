.186
.model tiny
.code

org 100h

extrn	framedr	:proc
extrn	printl	:proc


Start:	mov	di, (80*4+14)*2
	mov	cx, 52d
	mov	dx, 9d

	call	framedr

	mov 	si, offset msg		;line print
	mov 	di, (80*9+33)*2

	call 	printl			;line print

	mov 	ax, 4c00h
	int 	21h

msg: db, 'Hello, world!', 00

end Start