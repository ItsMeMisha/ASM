.model tiny
.code

org 100h

Start: 	mov ah, 0ah
	mov al, 13d
	mov bl, 4eh
	mov cx, 1h

	int 10h	

	mov ax, 4c00h
	int 21h

end Start