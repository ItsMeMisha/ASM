.186
.model tiny
.code
org 100h

extrn frext	:proc
Start:	call	frext

	mov	ax, 4c00h
	int	21h

end	Start