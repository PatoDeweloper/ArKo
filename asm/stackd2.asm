; nasm -f bin stack_bp.asm -o stack_bp.com
org 100h

start:
    ; ============================================================
    ; 1) USTAWIENIE STOSU
    ; ============================================================
    cli                     ; Wy³¹cz przerwania (dla bezpieczeñstwa)
    mov ax, cs              ; CS = segment kodu
    mov ss, ax              ; SS = CS › stos w tym samym segmencie
    mov sp, 0FFFEh          ; Ustaw wskaŸnik stosu na górê pamiêci
    sti                     ; W³¹cz z powrotem przerwania

    ; ============================================================
    ; 2) UTWORZENIE RAMKI STOSU
    ; ------------------------------------------------------------
    ; Tworzymy "ramkê" – obszar stosu, do którego bêdziemy siê odnosiæ przez BP.
    ; Robimy to dok³adnie tak, jak robi¹ to procedury, tylko bez CALL/RET.
    ; ============================================================
    push bp                 ; Zachowaj poprzedni¹ wartoœæ BP (stary wskaŸnik ramki)
    mov  bp, sp             ; Ustal nowy BP = SP › pocz¹tek nowej ramki stosu

    ; ============================================================
    ; 3) REZERWACJA MIEJSCA NA „LOKALNE ZMIENNE”
    ; ------------------------------------------------------------
    ; Rezerwujemy 4 bajty na stosie (2 lokalne zmienne po 2 bajty ka¿da).
    ; Stos roœnie w dó³ › SP siê zmniejszy.
    ; ============================================================
    sub sp, 4               ; SP = SP - 4 › rezerwacja miejsca

    ; ============================================================
    ; 4) ZAPIS ZMIENNYCH NA STOSIE
    ; ------------------------------------------------------------
    ; Zmienna 1 = [BP-2]
    ; Zmienna 2 = [BP-4]
    ; ============================================================
    mov word [bp-2], 1111h  ; zapisz 1111h do zmiennej1
    mov word [bp-4], 2222h  ; zapisz 2222h do zmiennej2

    ; ============================================================
    ; 5) ODCZYT I OPERACJE NA DANYCH ZE STOSU
    ; ------------------------------------------------------------
    ; BP jest punktem odniesienia, wiêc mo¿emy ³atwo czytaæ dane
    ; z okreœlonym przesuniêciem wzglêdem BP.
    ; ============================================================
    mov ax, [bp-2]          ; AX = zawartoœæ zmiennej1 (1111h)
    mov bx, [bp-4]          ; BX = zawartoœæ zmiennej2 (2222h)
    add ax, bx              ; AX = 1111h + 2222h = 3333h (wynik operacji)

    ; ============================================================
    ; 6) PRZYWRÓCENIE STOSU
    ; ------------------------------------------------------------
    ; Przywracamy stos do stanu sprzed rezerwacji zmiennych.
    ; mov sp, bp › SP wraca na pocz¹tek ramki,
    ; pop bp › przywraca poprzedni¹ wartoœæ BP.
    ; ============================================================
    mov sp, bp              ; SP wraca na pozycjê sprzed sub sp,4
    pop bp                  ; przywróæ stary BP

    ; ============================================================
    ; 7) WYŒWIETLENIE KOMUNIKATU (DOS, funkcja 09h)
    ; ============================================================
    mov dx, msg             ; DX = offset tekstu
    mov ah, 09h             ; AH = 09h › funkcja wypisywania
    int 21h                 ; Wywo³anie przerwania DOS › wypisz komunikat

    ; ============================================================
    ; 8) ZAKOÑCZENIE PROGRAMU
    ; ============================================================
    mov ax, 4C00h
    int 21h

; ============================================================
; DANE
; ============================================================
msg db 'Stos z BP dziala poprawnie. Lokalne zmienne OK.$'
