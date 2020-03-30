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
		push 	es ds

		call 	PrintBuf 

		pop 	ds es
		popa

		pushf
		call 	dword ptr cs:[Old28]

		iret
		endp

Old28   	dw 	0h
        	dw 	0h

;=================================================
; Prints buffer to file and flushes buffer
; Destr: AX, BX, CX, DX
;=================================================

PrintBuf	proc 

		push 	ds
		push 	cs
		pop 	ds
		
		mov 	cl, cs:BufEnd
		xor 	ch, ch
	
		push 	cx
					;open file
		mov 	ax, 3d01h
		mov 	dx, offset filespec
		int 	21h
		mov 	fileHandler, ax
					;set coursor to the end
		mov 	ax, 4202h
		mov 	bx, fileHandler
		xor 	cx, cx
		xor 	dx, dx
		int 	21h
					;write to file
		mov 	al, cs:BufBeg
		xor 	ah, ah
		mov 	dx, offset BUF
		add 	dx, ax
		pop 	cx
		mov 	ah, 40h
		mov 	bx, cs:fileHandler
		sub 	cl, cs:BufBeg
		xor 	ch, ch
		int 	21h
		
		add 	cl, cs:BufBeg
		xor 	ch, ch
		mov 	cs:BufBeg, cl
					;close file
		mov 	ah, 3eh
		mov 	bx, cs:fileHandler
		int 	21h

		pop 	ds
		ret
		endp

fileHandler 	dw 	0h

end
