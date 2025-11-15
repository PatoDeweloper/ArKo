org 100h
start:
	mov bl, 10
	mov al, [liczba]
	mul bl	; jednoargumentowa operacja logiczna 
	cmp ax,100
	ja wieksze_od_zera ;jg
	jb mniejsze_od_zera ;jl
	je zero ;jz
wieksze_od_zera:
	mov 	dx, wieksze
	jmp wypisz
mniejsze_od_zera:
	mov 	dx, mniejsze
	jmp wypisz
zero:
	mov 	dx, rowne
wypisz:
	mov	ah, 9
	int	21h
	jmp	koniec

koniec:
mov	ax, 4C00h
int	21h

mniejsze	db "Wynik jest mniejszy od stu$"
wieksze		db "Wynik jest wiekszy od stu$"
rowne		db "Wynik jest rowny sto$"
liczba		db 10