.model tiny
.code
org 100h

Start:	mov ax, 0b800h
	mov es, ax
	mov si, offset msg
	lodsb

	Cycle:	mov byte ptr es:[bx], al
		inc bx
		mov byte ptr es:[bx], dl
		inc dl
		inc bx
		lodsb
		cmp bx, 80*50-1
	jbe Cycle

	mov ax, 4c00h
	int 21h

msg: db 'Hello world!$'

end Start