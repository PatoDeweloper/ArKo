; Wpisaæ do pamiêci wartoœæ sta³¹, przepisaæ j¹ do rejestru i wyœwietliæ na ekranie.
; Przyklad adresowania bezpoœredniego

org 100h                ; Okreœla punkt pocz¹tkowy programu typu COM.
                        ; W plikach COM program zaczyna siê od offsetu 100h,
                        ; poniewa¿ pierwsze 256 bajtów (00h–FFh) zajmuje PSP (Program Segment Prefix)
                        ; – struktura u¿ywana przez DOS do zarz¹dzania uruchomionym programem.

section .text           ; Sekcja kodu – tutaj znajduj¹ siê instrukcje wykonywalne programu.

start:                  ; Etykieta oznaczaj¹ca pocz¹tek programu.
                        ; Mo¿e byæ u¿yta np. jako punkt wejœcia dla asemblera/linkera.

mov cx, [zmienna]       ; Za³aduj do rejestru CX wartoœæ bajtu znajduj¹cego siê pod etykiet¹ "zmienna".
                        ; W tym wypadku [zmienna] oznacza odczyt z pamiêci (adres zmiennej).
                        ; Rejestr CX bêdzie przechowywa³ tê wartoœæ (czyli 55 – kod ASCII znaku '7').

mov ah, 2               ; Ustaw kod funkcji DOS w rejestrze AH.
                        ; Funkcja 02h przerwania 21h – wyœwietlenie pojedynczego znaku na ekranie.
                        ; Znak, który ma zostaæ wyœwietlony, musi byæ w rejestrze DL.

mov dx, cx              ; Skopiuj zawartoœæ rejestru CX do rejestru DX.
                        ; W ten sposób znak, który by³ w CX (czyli wartoœæ zmiennej), 
                        ; trafia do DL (ni¿szej czêœci DX), gdzie oczekuje go funkcja 02h.

int 21h                 ; Wywo³aj przerwanie systemowe DOS (INT 21h).
                        ; System DOS odczyta wartoœæ z DL i wyœwietli odpowiadaj¹cy jej znak ASCII na ekranie.

mov ax, 4C00h           ; Przygotowanie do zakoñczenia programu.
                        ; Funkcja 4Ch przerwania 21h s³u¿y do zakoñczenia programu z kodem wyjœcia w AL.
                        ; W tym przypadku AL = 00h, czyli zakoñczenie bez b³êdów.

int 21h                 ; Wywo³anie przerwania DOS – zamkniêcie programu i powrót do systemu.

section .data           ; Sekcja danych – tutaj znajduj¹ siê zmienne, sta³e i bufory programu.

zmienna db 55           ; Definicja bajtu o nazwie "zmienna" i wartoœci 55.
                        ; Wartoœæ 55 to kod ASCII znaku '7'.
                        ; Mo¿na by te¿ zapisaæ: zmienna db '7'  – efekt by³by identyczny.
