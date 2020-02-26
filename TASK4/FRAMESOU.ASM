.186
.model tiny

;=================================================

rShadow	= 05dbh
bShadow	= 05dfh

tlCon	= 06c9h		;top left connor
trCon	= 06bbh		;top right connor
blCon	= 06c8h		;bottom left connor
brCon	= 06bch		;bottom	right connor

horiz	= 06cdh		;horiz line
vertic	= 06bah		;vertic line

fill	= 7e00h		;filler symbols

;=================================================

.code
locals @@
org 100h

;=================================================
; Draws a horizontal line
; Entry:DI - address of start
;	CX - lenght
;	AX - symb and clr of middle characters
;	BX - symb and clr of the right character
;	DX - synb and clr of the left character
; Destr:ES, DI, CX
;=================================================

public 	horline

horline	proc
	
		push 	0b800h
		pop 	es
		mov 	word ptr es:[di], BX
		add	di, 2
			rep 	stosw
		mov 	word ptr es:[di], DX
		add	di, 2

		ret

horline	endp

;=================================================
; Draws a shadow for the frame
; Entry:DI - left connor of the frame address
;	CX - width of the frame
;	DX - height of the frame
; Destr: AX, BX, SI, ES
;=================================================

public	frshad

frshad	proc

		push	di cx dx

		mov	ax, bShadow
		mov	bx, bShadow
		mov	si, dx
		mov	dx, bShadow

		add 	di, 2
		call	horline
		sub	di, 162d
		mov	ax, rShadow
		inc	si

@@rightSh: 	stosw
		sub	di, 162d
		dec	si
		cmp	si, 1
		jae	@@rightSh	

		pop	dx cx di

		ret
frshad	endp

;=================================================
; Draws a frame
; Entry:DI - left connor address
;	CX - width
;	DX - height
; Destr: AX, BX, SI, ES
;=================================================

public	framedr

framedr	proc

		push	di
		push	cx
		push	dx

		mov 	si, dx
		push	cx

		mov	ax, horiz	
		mov	bx, tlCon
		mov	dx, trCon	
		call	horline
		pop 	cx
		shl	cx, 1
		sub	di, cx
		shr	cx, 1
		add	di, 156d

		push	si

		mov	ax, fill
		mov	bx, vertic
		mov	dx, vertic
@@MID:		push	cx
		call	horline
		pop	cx
		shl	cx, 1
		sub	di, cx
		add	di, 156d
		shr	cx, 1
		dec	si
		cmp	si, 0
		ja	@@MID

		pop	si

		mov	ax, horiz
		mov	bx, blCon
		mov	dx, brCon
		push	cx
		call	horline
		pop	cx
		shl	cx, 1
		sub	di, cx
		shr	cx, 1
		mov	dx, si
		add	di, 156d
		call	frshad

		pop	dx
		pop	cx
		pop	di

		ret

framedr	endp

;=================================================
; Draws an extending frame
; Destr: AX, BX, CX, DX, ES, SI, DI
;=================================================

public frext

frext	proc

		mov	di, (80*11+33)*2
		mov	cx, 12
		mov	dx, 1
	
@@DRAW: 	sub	di, (80+3)*2
		add	cx, 6
		add	dx, 2
		call	framedr
		mov	ah, 86h
		push	cx
		push	dx
		mov	cx, 3
		mov	dx, 0d40h
		int	15h
		pop	dx
		pop	cx
		cmp	di, 160
		jae	@@DRAW

		ret

frext	endp

;=================================================
; Print Line in video memory
; Entry:SI offset of line
;	DI address in video memory
; Destr:AL, DI
;=================================================

public printl

printl	proc

		lodsb
@@NEXT:		stosb
		inc di
		lodsb
		cmp	al, 00
		jne	@@NEXT

		ret

printl	endp


end