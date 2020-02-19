.186
.model tiny
.code
locals @@
org 100h

;=================================================
; Draws a horizontal line
; Entry:DI - address of start
;	AL - character to draw in middle
;	AH - color attr
;	BL - left character
;	BH - left color attr
;	DL - right character
;	DH - right color attr
;	CX - lenght
; Destr:ES, DI, CX
;=================================================

public 	horline

horline	proc
	
	push 	0b800h
	pop 	es
	mov word ptr es:[di], BX
	add	di, 2
	rep 	stosw
	mov word ptr es:[di], DX
	add	di, 2
	ret

horline	endp

;=================================================
; Print Line in video memory
; Entry:SI offset of line
;	DI address in video memory
; Destr:AL, DI
;=================================================

public printl

printl	proc

	lodsb
@@NEXT:	stosb
	inc di
	lodsb
	cmp	al, 00
	jne	@@NEXT

	ret

printl	endp


end