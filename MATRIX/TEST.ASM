.186
.model tiny

.code
org	100h
extrn	scrsft	:proc

Start:		call	scrsft

		mov	ax, 4c00h
		int	21h

end		Start