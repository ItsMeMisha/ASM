.model tiny
.code

org 100h

Start:	mov ah, 02h
	mov dl, '!'
	int 21h

	mov ax, 4c00h
	int 21h

end Start