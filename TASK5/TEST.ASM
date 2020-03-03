.186
.model tiny
.code

org 	100h

Start:	
	mov	dx, offset file
	mov	ax, 3d02h
	int	21h
	mov	bx, ax
	
	mov	dl, al
	mov	ax, 0200h
	int	21h

	mov	dx, offset txt
	mov	cx, 12d
	
	mov	ax, 4000h
	int	21h

	mov	ax, 3e00h
	int	21h

	mov	ax, 4c00h
	int	21h

.data
file	db 'log.txt', 0
txt	db 'aaaassssdddd', 0

end	Start