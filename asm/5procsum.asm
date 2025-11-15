org 100h                        ; Pocz¹tek programu .COM (adres ³adowania przez DOS: CS:0100h)
                                ; DS = CS › dane i kod w tym samym segmencie

; ============================================================
;  G£ÓWNY PROGRAM
; ============================================================

start:

    push 3                      ; Odk³adamy pierwszy argument (liczba 3) na stos
                                ; SP = SP - 2, [SS:SP] = 0003h

    push 5                      ; Odk³adamy drugi argument (liczba 5) na stos
                                ; SP = SP - 2, [SS:SP] = 0005h
                                ; Teraz stos zawiera (od góry): [5], [3]

    call sumuj                  ; Wywo³anie procedury „sumuj”
                                ; CALL:
                                ;   - odk³ada na stos adres powrotu (adres instrukcji po CALL)
                                ;   - skacze do etykiety "sumuj"
                                ; Stos: [adres powrotu], [5], [3]

                                ; Po powrocie z procedury wynik znajduje siê w rejestrze AX.
                                ; Procedura u¿ywa "ret 4" › sama usuwa swoje argumenty ze stosu.

    cmp ax, 8                   ; Porównanie wyniku (AX) z 8
                                ; Ustawia flagi (ZF, SF, CF...)
                                ; Jeœli AX ? 8 › flaga ZF = 0 › wykonany zostanie skok jnz

    jnz koniec                  ; Skok do "koniec", jeœli wynik nie jest równy 8

    mov ah, 9                   ; AH = 09h › funkcja DOS „Display String”
    mov dx, napis               ; DX = offset tekstu (adres napisu w tym samym segmencie)
    int 21h                     ; Wywo³anie DOS-a: wypisz ci¹g znaków zakoñczony znakiem '$'

koniec:
    mov ah, 4Ch                 ; AH = 4Ch › funkcja DOS: zakoñcz program
    int 21h                     ; Powrót do DOS-a

; ============================================================
;  PROCEDURA: sumuj
;  Opis: pobiera 2 liczby ze stosu, dodaje je i zwraca wynik w AX
; ============================================================

; UWAGA: uk³ad stosu po wywo³aniu CALL sumuj wygl¹da tak:
;
;   [BP+6] › pierwszy argument (3)
;   [BP+4] › drugi argument (5)
;   [BP+2] › adres powrotu (IP)
;   [BP+0] › stary BP (zapisany przez push bp)
;
;  dlatego korzystamy z BP+6 i BP+4, ¿eby dostaæ siê do argumentów

sumuj:
    push bp                     ; Zachowaj poprzedni¹ wartoœæ BP na stosie
                                ; SP = SP - 2, [SS:SP] = stary BP

    mov  bp, sp                 ; Ustal BP = SP › teraz BP jest baz¹ ramki stosu
                                ; Dziêki temu mo¿emy adresowaæ dane wzglêdem BP

    mov  ax, [bp+6]             ; Za³aduj pierwszy argument (3) do AX
    mov  bx, [bp+4]             ; Za³aduj drugi argument (5) do BX
    add  ax, bx                 ; AX = AX + BX = 3 + 5 = 8
                                ; Wynik (8) zapisany w AX › bêdzie to wartoœæ zwracana

    pop  bp                     ; Przywróæ poprzedni¹ wartoœæ BP
                                ; SP = SP + 2 › stos wraca do stanu sprzed "push bp"

    ret  4                      ; RET + 4 = zakoñcz procedurê i jednoczeœnie zdejmij 2 argumenty (4 bajty)
                                ; SP = SP + 2 (adres powrotu) + 4 (argumenty) › stos w stanie jak przed CALL

; ============================================================
;  DANE
; ============================================================

napis db "Wynik jest równy 8$", 0  ; Tekst zakoñczony znakiem '$' – wymagane przez DOS funkcjê 09h
