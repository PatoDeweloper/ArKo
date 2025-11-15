	; To jest komentarz
	; tu można wstawić:
	; section .text
	; aby dać znać NASMowi, że to będzie w sekcji kodu.

	section .text   ; poczatek sekcji kodu


	org 100h	; Ta linia jest informacją dla kompilatora, że program wynikowy będzie typu .com. 
			; Informuje ona również o tym, że nasz kod znajdować się będzie po uruchomieniu pod adresem 100h (256 dziesiętnie).

	start:		; Start: może być to dowolna nazwa z dwukropkiem. Określa ona początek kodu w programie.
	
	; mov byte [zmienna], 35 ; nadpisanie danych w komorce pamieci
	mov cx, [zmienna]
	sub cx, 3 ; 55 - 3 = 52 pzresuniecie w tablicy ASCII
	mov ah, 2
	mov dx, cx
	int 21h

	mov ax, 4c00h
	int 21h			

	section .data   ; poczatek sekcji danych zainicjowanych
	
	zmienna db 55

;nasm -o naszplik.com -f bin naszplik.asm

;[] - wskaźnik do wartosci pod okreslona komorka pamieci