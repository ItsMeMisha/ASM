.186
.model tiny
.code
org 	100h


public		Old09
public		New09

extrn		BufBeg	:byte
extrn		BufEnd	:byte
extrn		BUF	:byte
extrn		COUNT	:byte

;=================================================
; New int 09h that should read pushed keys and write them to BUF
;=================================================

New09   proc
        pusha
		push es ds

	;call original int 9h
		pushf
		call dword ptr cs:[Old09]

		call readToBuf
		
		pop ds es
		popa
		iret
		endp
		

Old09   dw 0h
        dw 0h

		

readToBuf proc 
	
		push ds
		push cs
		pop ds

	;saving pressed key
		mov ah, 01h	
		int 16h

		jz @@exit

	;setting bx as len 
		mov bl, BufEnd
		xor bh, bh

	;saving key to buff
		mov BUF[bx], al
		inc BufEnd


@@exit:

		pop ds

		ret
		endp


end
