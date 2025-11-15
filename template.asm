	; To jest komentarz
	; tu mo¿na wstawiæ:
	; section .text
	; aby daæ znaæ NASMowi, ¿e to bêdzie w sekcji kodu.

	section .text   ; poczatek sekcji kodu


	org 100h	; Ta linia jest informacj¹ dla kompilatora, ¿e program wynikowy bêdzie typu .com. 
			; Informuje ona równie¿ o tym, ¿e nasz kod znajdowaæ siê bêdzie po uruchomieniu pod adresem 100h (256 dziesiêtnie).

	start:		; Start: mo¿e byæ to dowolna nazwa z dwukropkiem. Okreœla ona pocz¹tek kodu w programie.

	mov ah, 9
	mov dx, napis
	mov dx, napis2
	int 21h

	mov ah, 0
	int 16h

	mov ax, 4c00h
	int 21h			

	section .data   ; poczatek sekcji danych zainicjowanych

	napis db "Czesc", 10, 13, "$"	; 10, 13 to jest powrót karetki ; db - define byte ; dw; dd - define double wordl 4 bajty; dq quad word; dt
	napis2 db 68, 97, 119, 105, 100 "$"

	section .bss	; poczatek sekcji deklaracji zmiennych, np:
			; liczba: resb 1 ; REServe 1 Byte 





;nasm -o naszplik.com -f bin naszplik.asm

data1 db 0
data2 dd 65
data3 dw 1000
data4 db 110101b
data5 db 0A2h
data6 db 17o
data8 dd 0FFFF1A9h
data9 db "A"
data10 db "w","o", "p" ;data10 wskazuje na "w" data10+1 na "o" i tak dalej