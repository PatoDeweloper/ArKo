	; To jest komentarz
	; tu można wstawić:
	; section .text
	; aby dać znać NASMowi, że to będzie w sekcji kodu.

	section .text   ; poczatek sekcji kodu


	org 100h	; Ta linia jest informacją dla kompilatora, że program wynikowy będzie typu .com. 
			; Informuje ona również o tym, że nasz kod znajdować się będzie po uruchomieniu pod adresem 100h (256 dziesiętnie).

	start:		; Start: może być to dowolna nazwa z dwukropkiem. Określa ona początek kodu w programie.
	
	mov cx, 4
	label:
	mov ah, 2
	mov dx, [zmienna]
	sub dx, 4
	add dx, cx
	int 21h
	LOOP label

	mov ah, 1
	int 21h

	mov dl, al
	mov ah, 2
	int 21h
	
	mov ax, 4c00h
	int 21h		

	section .data   ; poczatek sekcji danych zainicjowanych
	
	zmienna db 55, 54, 53, 52

;nasm -o naszplik.com -f bin naszplik.asm