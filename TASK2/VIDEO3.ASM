.model tiny

rShadow = 05dbh
bShadow = 05dfh

tlCon	= 06c9h
trCon	= 06bbh
blCon	= 06c8h
brCon	= 06bch

horiz	= 06cdh
vertic	= 06bah

fill	= 7e00h

x1 	= 14d 
x2	= 66d
y1	= 4d
y2	= 13d

.code

org 100h

Start:	mov ax, 0b800h
	mov es, ax

	mov bx, (80*y1+x1)*2		;top start
	mov cx, horiz
	mov word ptr es:[bx], tlCon
	add bx, 2
	
top:	mov word ptr es:[bx], cx
	add bx, 2
	cmp bx, (80*y1+x2)*2
	jb top

	mov word ptr es:[bx], trCon	;top end
	
	mov bx, (80*(y1+1)+x1)*2
	mov cx, vertic

LandR: 	mov word ptr es:[bx], cx	;left and right start
	mov word ptr es:[bx+(x2-x1)*2], cx
	mov word ptr es:[bx+(x2-x1+1)*2], rShadow
	add bx, 160
	cmp bx, (80*y2+x1)*2
	jb LandR			;left and right end

	mov word ptr es:[bx], blCon	;bottom start
	add bx, 2
	mov cx, horiz

bottom:	mov word ptr es:[bx], cx
	mov word ptr es:[bx+160], bShadow
	add bx, 2
	cmp bx, (80*y2+x2)*2
	jb bottom			

	mov word ptr es:[bx], brCon
	mov word ptr es:[bx+2], rShadow
	mov word ptr es:[bx+162], bShadow
	mov word ptr es:[bx+160], bShadow;bottom end

	mov dx, 160*(y1+1)		;filler start
	mov bx, 30d
	mov cx, fill

filler:	add bx, dx
	mov word ptr es:[bx], cx
	add bx, 2
	sub bx, dx
	cmp bx, (x2-1)*2
	jb filler
	mov bx, 30d
	add dx, 160d
	cmp dx, 160*y2
	jb filler			;filler end

	mov si, offset msg
	lodsb
	mov bx, (80*((y1+y2)/2)+33)*2

line:	mov byte ptr es:[bx], al
	add bx, 2
	lodsb
	cmp al, '$'
	jne line

	mov ax, 4c00h
	int 21h

msg: db, 'Hello, world!$'

end Start