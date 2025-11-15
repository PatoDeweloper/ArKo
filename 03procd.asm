org 100h

start:
    call procedure     ; wywołanie procedury
    mov ah, 4Ch        ; funkcja DOS: zakończ program
    int 21h            ; powrót do DOS

procedure:
    mov ax, 9          ; AX = 9
    mov bx, 11         ; BX = 11
    add ax, bx         ; AX = AX + BX = 20 (wynik)
    ret                ; powrót do miejsca po CALL
