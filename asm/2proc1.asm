; Program odczytuj¹cy z klawiatury napis i wypisuj¹cy go.

org 100h

	mov	ah, 9		; funkcja wyœwietlania na ekran
	mov	dx, jak_masz	
	int	21h		

	mov	ah, 0ah	; funkcja pobierania danych z klawiatury
	mov	dx, imie	
	int	21h		; pobierz dane

	mov	ah, 9
	mov	dx, powitanie
	int	21h		; wyœwietl napis "Czeœæ"

	mov	ah, 9
	mov	dx, imie+2	; adres wpisanych danych
	int	21h		

	mov	ax, 4c00h
	int	21h

	jak_masz	db	"Jak masz na imie? $"
	imie		db 	20	; maksymalna liczba znaków do pobrania
			db 	0	; tu dostaniemy, ile znaków pobrano
			times 22 db "$"	; miejsce na dane

	powitanie	db	10, 13, 10, 13, "Czesc $"