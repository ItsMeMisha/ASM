.186
locals @@
.model tiny
.code

;=================================================
; Finds lenght of the string
; Entry:ES - segment of memory
;	DI - address of the string
; Exit:	AX - lenght of the string
; Destr:CX, DI
;=================================================

public 	strlen

strlen	proc

		mov 	al, 0h
		mov 	cx, 0ffffh
		cld
		repne	scasb
		mov 	ax, 0ffffh
		sub	ax, cx
		inc 	ax

		ret
strlen	endp

;=================================================
; Finds the first occurrence of character in string
; Entry:ES - segment of memory
;	DI - string address
;	AL - char to find
; Exit:	DI - address of the character
; Destr:CX, BL
;=================================================

public	strchr

strchr	proc

		mov	bl, al
		call	strlen
		mov	cx, ax
		mov 	bl, al
		
		cld
		repne	scasb
		je	@@FOUND
		mov	di, 0
		jmp	@@EXIT

@@FOUND:	dec	di

@@EXIT:		ret
strchr	endp

;=================================================
; Copies first string to second
; Entry:DS - segment of the first string
;	SI - address of the beginning of the first string
;	ES - segment of the second string
;	DI - address of the beginning of the second string
; Destr;SI, DI, CX, AX
;=================================================

public 	strcpy

strcpy	proc

		push 	es
		push	di
		push	ds
		pop	es
		mov	di, si
	
		call	strlen
		mov	cx, ax
	
		pop	di
		pop	es
		
		cld	
		rep	movsb

		ret
strcpy	endp

;=================================================
; Compares the first string with the second
; Entry:DS - segment of the first string
;	SI - address of the beginning of the first string
;	ES - segment of the second string
;	DI - address of the beginning of the second string;
; Exit:	AL - result of the comparing
; Destr:SI, DI
;=================================================

public 	strcmp

strcmp	proc

		call	strlen
		mov	cx, ax
	
		cld
		rep	cmpsb
		ja	@@BIG
		dec	si
		dec	di
		lodsb
		cmp	al, byte ptr es:[di]
		jb	@@LESS

		mov 	al, 0
		jmp	@@END

@@BIG:		mov	al, 1
		jmp	@@END

@@LESS:		mov	al, -1

@@END:		ret
strcmp	endp

end
;=================================================
;		END OF FILE
;=================================================
