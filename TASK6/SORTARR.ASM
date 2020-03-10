.186
.model tiny
.code
org	100h
locals	@@

public	sortfwd
public	sortbkd

;=================================================
; Sortes array of bytes forward
; Entry:ES - segment where array is
;	DI - address of array in segment
;	CX - size of array
; Dstr:	CX, SI, AX, BX, DX
;=================================================

sortfwd		proc

		mov	bx, cx

@@sortStart:	push	cx	;double cycle begin
		push	di

		add	di, bx
		sub	di, cx
		
		mov	al, byte ptr es:[di]
		mov	si, di
		inc	di

@@insideCy:	cmp	al, byte ptr es:[di]
		jb	@@bigeq

		mov	ah, byte ptr es:[di]
		mov	byte ptr es:[di], al
		mov	byte ptr es:[si], ah
		mov	al, ah

@@bigeq:	inc	di
		dec	cx
		cmp	cx, 1
		jne	@@insideCy
		
		pop	di
		pop	cx
		dec	cx
		cmp	cx, 1
		jne	@@sortStart
		
		ret
sortfwd		endp

;=================================================
; Sortes array of bytes reverse
; Entry:ES - segment where array is
;	DI - address of array in segment
;	CX - size of array
; Dstr:	CX, SI, AX, BX, DX
;=================================================

sortbkd		proc

		mov	bx, cx

@@sortStart2:	push	cx	;double cycle begin
		push	di

		add	di, bx
		sub	di, cx
		
		mov	al, byte ptr es:[di]
		mov	si, di
		inc	di

@@insideCy2:	cmp	al, byte ptr es:[di]
		ja	@@lesseq

		mov	ah, byte ptr es:[di]
		mov	byte ptr es:[di], al
		mov	byte ptr es:[si], ah
		mov	al, ah

@@lesseq:	inc	di
		dec	cx
		cmp	cx, 1
		jne	@@insideCy2
		
		pop	di
		pop	cx
		dec	cx
		cmp	cx, 1
		jne	@@sortStart2
		
		ret
sortbkd		endp

end
