org 100h

start:

mov 	cx, 5 ;chcemy iterowaæ 5 razy

petla:

	mov	ah, 9
	mov	dx, napis
	int	21h
	;nie ma dec	cx
	loop 	petla

mov	ax, 	4C00h
int	21h

napis	db	"Napis $"