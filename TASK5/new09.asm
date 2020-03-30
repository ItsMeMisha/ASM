.186
.model tiny
.code
org 	100h


public		Old09
public		New09
public		MATRIX

extrn		framedr	:proc
extrn		printl	:proc


extrn		BufBeg	:byte
extrn		BufEnd	:byte
extrn		BUF	:byte
extrn		COUNT	:byte

;=================================================
; New int 09h that should read pushed keys and write them to BUF
;=================================================

New09   	proc
        	pusha
    		push 	es ds

	        call    checkMatrix
					
		pushf
		call 	dword ptr cs:[Old09]

		call 	readStroke
		
		pop 	ds es
		popa
		iret
		endp
		

Old09   dw 	0h
        dw 	0h

;=================================================
; Reads a ASCII code from the keybord buffer
; Destr: AX, BX
;=================================================

readStroke 	proc 
	
		push 	ds
		push 	cs
		pop 	ds
				;read ASCII code
		mov 	ah, 01h	
		int 	16h
		jz 	@@END
				
		mov 	bl, cs:BufEnd
		xor 	bh, bh
				;writing to buffer
		mov 	cs:BUF[bx], al
		inc 	cs:BufEnd

@@END:		pop 	ds

		ret
		endp

;=================================================
; Checks if typed 'red'
; Entry: AL - typed letter
; Destr: BX
;=================================================

checkRed	proc
					;checks scaned scancode
		mov	bl, cs:CURLETTER
		mov	bh, 0h
		cmp	al, cs:RED[bx]
		jne	@@WRONGLET
					;checks wether all codes are scaned
		inc	cs:CURLETTER
		cmp	cs:CURLETTER, 6h
		jne	@@ENDCHECK

		mov	cs:MATRIX, 0h

@@WRONGLET:	mov	cs:CURLETTER, 0h

@@ENDCHECK:	ret
		endp

;=================================================
; Checks if matrix should be launched or has been already launched
;=================================================

checkMatrix 	proc

		push	ax bx cx dx di si es

		in	al, 60h
		cmp	cs:MATRIX, 0
		jne	cs:@@GOOUT

		cmp	al, 3ah		;capsLock
		jne	@@NotYet
					;frame
		mov	cs:MATRIX, 1
		mov	di, (80*4+14)*2
		mov	cx, 52d
		mov	dx, 9d
		call	framedr
					;line in frame
		mov	si, offset cs:WAKEUP
		mov	di, (80*9+33)*2
		push	cs
		pop	ds
		call	printl
		
		mov	cs:MATRIX, 1
		jmp	cs:@@NotYet

@@GOOUT:	call	checkRed
		cmp	cs:MATRIX, 1
		je	cs:@@NotYet

@@NOTYET:	pop	es si di dx cx bx ax


	        ret
	        endp


RED		db	13h, 93h, 12h, 92h, 20h, 0A0h	;'red' in scancodes
CURLETTER	db	0h

MATRIX		dw	0h

WAKEUP		db 	'WAKE UP, NEO', 0h

end
