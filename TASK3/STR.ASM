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

	mov 	al, 0
	mov 	cx, 0ffffh
	repne	scansb
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
; Destr:CX
;=================================================

public	strchr

strchr	proc

	ret
strchr	endp

;=================================================
;
;=================================================

public 	strcpy

strcpy	proc

	ret
strcpy	endp

;=================================================
;
;=================================================

public 	strcmp

strcmp	proc

	ret
strcmp	endp

;=================================================
;		END OF FILE
;=================================================