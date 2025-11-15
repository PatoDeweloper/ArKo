org 100h                  ; Punkt startowy programu .COM (ładowany przez DOS pod CS:0100h)

; ===========================================================
;  GŁÓWNY PROGRAM
; ===========================================================
start:
    mov bx, prog_start    ; W rejestrze BX umieszczamy adres napisu "Program start."
    call Print            ; Wywołanie procedury Print – wypisze tekst pod adresem DS:BX

    mov bx, hello_world   ; BX = adres napisu "Hello world!"
    call Print            ; Wywołanie Print – wypisze kolejny tekst

    mov bx, prog_end      ; BX = adres napisu "Program end."
    call Print            ; Wywołanie Print – wypisze ostatni tekst

    mov ax, 4C00h         ; Funkcja 4Ch DOS – zakończenie programu
    int 21h               ; Zakończ i wróć do systemu (kod powrotu = 0)

; ===========================================================
;  DANE – ciągi znaków zakończone bajtem 0
; ===========================================================
prog_start  db "Program start.", 10, 0      ; Tekst + znak nowej linii (10) + bajt 0 jako terminator
hello_world db "Hello world!", 10, 0        ; Drugi napis, zakończony 0
prog_end    db "Program end.", 10, 0        ; Trzeci napis, zakończony 0


; ===========================================================
;  PROCEDURA: Print
;  Zadanie: wypisać na ekran tekst, którego adres znajduje się w DS:BX
;  Mechanizm: znak po znaku, dopóki nie napotka bajtu 0
; ===========================================================
Print:
    mov ah, 2              ; Funkcja DOS 02h: wypisz pojedynczy znak z DL na ekran
Print_loop:
    mov dl, [ds:bx]        ; Pobierz kolejny bajt z pamięci (tekst wskazywany przez BX)
    cmp dl, 0              ; Sprawdź, czy bajt = 0 (koniec tekstu)
    jz end                 ; Jeśli tak – skocz do końca procedury
    int 21h                ; Wywołanie DOS: wypisz znak w DL
    inc bx                 ; Przejdź do następnego bajtu tekstu
    jmp Print_loop         ; Powtórz aż do bajtu 0

end:
    ret                    ; Zakończ procedurę i wróć do miejsca po CALL
