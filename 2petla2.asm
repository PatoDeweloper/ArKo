start:

mov cx, 5 ;chcemy iterowaæ 5 razy

petla:

	mov	ah, 9
	mov	dx, napis
	int	21h
	dec	cx
	jnz 	petla

mov	ax, 	4C00h
int	21h

napis	db	"Napis $"