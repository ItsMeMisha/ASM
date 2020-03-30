.186
.model tiny
.code
org 	100h
locals @@

extrn		BufBeg	:byte
extrn		BufEnd	:byte
extrn		BUF	:byte
extrn		COUNT	:byte
extrn		filespec:byte

public		Old28
public		New28

;=================================================
; New int 28h prints COUNT bytes from BUF to filespec and set COUNT to 0
;=================================================

New28   proc
		pusha
		push es ds

		call PrintBuf 

		pop ds es
		popa

	;call original int 28h
		pushf
		call dword ptr cs:[Old28]

		iret
		endp

Old28   dw 0h
        dw 0h

PrintBuf proc 


		push ds
		push cs
		pop ds
		
		mov cl, cs:BufEnd
		xor ch, ch

		;cmp head_ind, cl
		;je @@exit
	
		push cx

		;mov cl, tail_ind
	;opening file by adress in ds:dx and saving its handler  
		mov ax, 3d01h; 
		mov dx, offset filespec
		int 21h
		mov fileHandler, ax


	;moving cursor to the end of file
		mov ax, 4202h
		mov bx, fileHandler
		xor cx, cx
		xor dx, dx
		int 21h

;!!! 
		mov al, BufBeg
		xor ah, ah
		mov dx, offset BUF
		add dx, ax

		pop cx
	;writing to file
		mov ah, 40h
		mov bx, fileHandler
		sub cl, BufBeg
		xor ch, ch
		int 21h
		
		add cl, BufBeg
		xor ch, ch
		mov BufBeg, cl

	;closing file
		mov ah, 3eh
		mov bx, fileHandler
		int 21h

@@exit:
		pop ds
		ret
		endp


fileHandler dw 0h

end
