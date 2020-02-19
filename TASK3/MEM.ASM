.186
locals @@
.model tiny
.code

;=================================================
; Finds the first occurrence of value in memory
; Entry:ES - segment of memory
;	DI - address of the memory area in ES
;	CX - lenght of the memory area
;	AL - value to find
; Exit:	DI - address of the first byte with value AL
; Destr:CX
;=================================================

public 	memchr

memchr 	proc
	
	repne	scasb
	je	@@FOUND
	mov 	di, 0
	
@@FOUND	dec 	di
	ret
memchr	endp

;=================================================
; Compares first cx bytes of one area of memory with other one
; Entry:DS - first memory segment
;	SI - address of the beginning of the first area
;	ES - second memory segment
;	DI - address of the beginning of the second area
;	CX - lenght of the areas
; Exit:	AL - -1 if first is less, 1 if first is more, 0 if equal
; Destr:CX, SI, DI
;=================================================

public	memcmp

memcmp 	proc

	repne 	cmpsb
	ja 	@@BIGGER
	jb 	@@LESS

	mov 	al, 0
	jmp 	@@END

@@BIGGER mov	al, 1
	jmp 	@@END

@@LESS	mov	al, -1

@@END	ret
memcmp	endp

;=================================================
; Sets value of AL to each byte of the memory area
; Entry:ES - segment of memory
;	DI - address of the beginning of the area
;	CX - lenght of the area
;	AL - value to be set
; Destr:DI, CX
;=================================================

public 	memset

memset 	proc

	rep	stosb

	ret
memset	endp

;=================================================
; Copies first CX bytes from first area to second
: Entry:DS - first memory segment
;	SI - the beginning of the first area
;	ES - second memory segment
;	DI - the beginning of the second area
;	CX - lenght of the first area
; Destr:CX, DI, SI
;=================================================

public	memcpy

memcpy	proc

	rep 	movsb

	ret
memcpy	endp

;=================================================
;		END OF FILE
;=================================================