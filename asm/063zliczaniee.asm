; Zliczanie wyst¹pieñ litery 'E' przy u¿yciu SCASB + REPNE
; NASM 16-bit (.COM)
org 100h

start:
    cld                     ; DF=0 (przód › ty³)
    mov di, text            ; ES:DI › bufor
    mov cx, text_len        ; liczba bajtów do skanowania
    mov al, 'E'             ; szukany znak
    xor bx, bx              ; BX = licznik wyst¹pieñ

szukaj:
    repne scasb             ; szukaj a¿ [ES:DI] == AL lub CX==0
    jnz koniec              ; jeœli CX==0 › brak dalszych dopasowañ
    inc bx                  ; trafienie › zwiêksz licznik
    cmp cx, 0
    jne szukaj              ; jeœli s¹ jeszcze bajty › szukaj dalej

koniec:
    ; Wypisz komunikat i liczbê (zak³adamy wynik 0–9)
    mov dx, msg
    mov ah, 09h
    int 21h

    mov dl, bl              ; BL = liczba
    add dl, 30h             ; ASCII
    mov ah, 02h
    int 21h

    mov ax, 4C00h
    int 21h

; --- Dane ---
text     db 'TEKST PRZYKLADOWY Z LITERAMI EEEE$', 0
text_len equ ($ - text - 1)   ; bez bajtu 0
msg      db 'Liczba liter E: ', '$'

