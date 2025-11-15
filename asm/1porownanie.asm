;--------------------------------------------------------
; Program: Porównywanie dwóch cyfr wprowadzonych z klawiatury
; Autor: [tu mo¿esz wpisaæ swoje imiê]
; Œrodowisko: DOS (.COM), asembler NASM
; Cel: pobraæ dwie cyfry, sprawdziæ poprawnoœæ, porównaæ je i
;      wypisaæ odpowiedni komunikat.
;--------------------------------------------------------

org 100h                 ; plik COM ³adowany od adresu 100h

section .text
start:

    ; --- Wyœwietlenie komunikatu tytu³owego ---
    mov dx, label         ; DX ‹ adres napisu
    mov ah, 9             ; funkcja 09h DOS – wypisanie ³añcucha zakoñczonego '$'
    int 21h

    ; --- Wczytanie pierwszego znaku z klawiatury ---
    mov ah, 1             ; funkcja 01h DOS – pobranie znaku (z echem)
    int 21h               ; po wykonaniu AL = kod ASCII znaku
    mov [pierwsza], al    ; zapisz pierwszy znak do pamiêci (zmienna 'pierwsza')
    mov bl, [pierwsza]    ; przenieœ go równie¿ do rejestru BL

    ; --- Sprawdzenie czy pierwszy znak to cyfra (kod ASCII 48–57) ---
    cmp bl, 48            ; porównaj z '0' (48 dziesiêtnie)
    jl zla                ; jeœli mniejszy › to nie cyfra
    cmp bl, 57            ; porównaj z '9' (57 dziesiêtnie)
    jg zla                ; jeœli wiêkszy › to nie cyfra

    ; --- Wczytanie drugiego znaku z klawiatury ---
    mov ah, 1             ; ponownie funkcja 01h – pobranie znaku
    int 21h
    mov [druga], al       ; zapisz w pamiêci
    mov cl, [druga]       ; przenieœ do rejestru CL

    ; --- Sprawdzenie czy drugi znak to cyfra (48–57) ---
    cmp cl, 48
    jl zla
    cmp cl, 57
    jg zla

    ; ----------------------------------------------------------
    ; Porównanie dwóch wczytanych znaków (kodów ASCII cyfr)
    ; Dla cyfr '0'..'9' porz¹dek ASCII odpowiada porz¹dkowi liczbowemu
    ; ----------------------------------------------------------
    cmp bl, cl            ; porównaj pierwszy znak z drugim
    jg wieksza            ; jeœli BL > CL › pierwsza cyfra wiêksza
    je rowna              ; jeœli BL = CL › liczby równe
    jl mniejsza           ; jeœli BL < CL › druga cyfra wiêksza

; --- Etykiety dla poszczególnych wyników ---

wieksza:
    mov dx, wieksza_t     ; adres napisu "Wieksza"
    jmp wypisz            ; przejdŸ do wypisania tekstu

rowna:
    mov dx, rowna_t       ; adres napisu "Rowna"
    jmp wypisz

mniejsza:
    mov dx, mniejsza_t    ; adres napisu "Mniejsza"
    jmp wypisz

; --- Obs³uga b³êdnego znaku ---

zla:
    mov dx, zla_t         ; adres komunikatu "Podano zly znak"
    jmp wypisz

; --- Wspólna procedura wypisywania komunikatu ---

wypisz:
    mov ah, 9             ; funkcja DOS – wyœwietl ³añcuch znaków
    int 21h

    ; --- Zakoñczenie programu ---
    mov ax, 4C00h         ; funkcja 4Ch – zakoñczenie programu z kodem 0
    int 21h


;========================================================
section .data

label db "Porownywanie liczb", 10, 13, "$"   ; komunikat tytu³owy (CR/LF + '$')
zla_t db "Podano zly znak", 10, 13, "$"      ; komunikat b³êdu
wieksza_t db "Wieksza$", 10, 13, "$"         ; wynik: pierwsza wiêksza
rowna_t db "Rowna$", 10, 13, "$"             ; wynik: liczby równe
mniejsza_t db "Mniejsza$", 10, 13, "$"       ; wynik: druga wiêksza

pierwsza db 0        ; miejsce na pierwsz¹ cyfrê (pocz¹tkowa wartoœæ nieistotna)
druga db 0           ; miejsce na drug¹ cyfrê

section .bss
; nieu¿ywana sekcja – brak zmiennych dynamicznych

;========================================================
; Kompilacja (NASM, plik .COM):
; nasm -f bin program.asm -o program.com
;========================================================
