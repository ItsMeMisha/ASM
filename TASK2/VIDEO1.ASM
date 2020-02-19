.model tiny
.code

org 100h

Start:	mov al, 03h
	int 10h

	mov ax, 0e00h

	Cycle:	int 10h
		inc al
		cmp al, 0ffh
	jb Cycle

	mov ax, 4c00h
	int 21h

end Start