.186
.model tiny

;=================================================

rShadow = 05dbh
bShadow = 05dfh

tlCon	= 06c9h		;top left connor
trCon	= 06bbh		;top right connor
blCon	= 06c8h		;bottom left connor
brCon	= 06bch		;bottom right connor

horiz	= 06cdh		;horiz line
vertic	= 06bah		;vertic line

fill	= 7e00h		;filler symbols

x1 	= 14d 
x2	= 66d
y1	= 4d
y2	= 13d

;=================================================

.code
org 100h
extrn	horline: proc
extrn	printl:  proc
Start:	mov	ax, 0b800h
	mov 	es, ax

	mov 	cx, x2-x1-1		;top start
	mov	ax, horiz
	mov	bx, tlCon
	mov	dx, trCon
	mov	di, (80*y1+x1)*2
	call	horline			;top end

 	mov 	ax, fill		;left and right start
	mov	bx, vertic
	mov	dx, vertic
	mov	si, 160*(y1+1)
LandR:	mov	di, x1*2
	add	di, si
	mov	cx, x2-x1-1
	call	horline
	mov word ptr es:[di], rShadow
	add	si, 160
	cmp	si, 160*y2
	jb 	LandR			;left and right end


	mov	ax, horiz		;bottom start
	mov	bx, blCon
	mov	dx, brCon
	mov	di, (80*y2+x1)*2
	mov	cx, x2-x1-1
	call	horline			
	mov word ptr es:[di], rShadow	;bottom end
	

;Shadows
	mov	ax, bShadow
	mov	bx, bShadow
	mov	dx, bShadow
	mov di, (80*(y2+1) + x1+2)*2
	mov	cx, x2-x1-2
	call	horline

	mov 	si, offset msg		;line print
	mov 	di, (80*((y1+y2)/2)+33)*2

	call 	printl			;line print

	mov 	ax, 4c00h
	int 	21h

msg: db, 'Hello, world!', 00

end Start