.model tiny
.code
org 100h

Start:	mov ah, 09h
	mov dx, offset Gorshok
	int 21h

	mov ax, 4c00h
	int 21h

Gorshok: db "��� ��� �㦨��", 13, 10
	db "����� ��������", 13, 10, '$'

end Start