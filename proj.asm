section .text
org 100h

start:
    mov ah, 9
    mov dx, com1
    int 21h

run:
    mov ax, 0
    mov [count], ax

    mov ah, 9
    mov dx, com2
    int 21h

read:
    mov ah, 1
    int 21h
    cmp al, 32
    je end
    cmp al, 13
    je process

check_sign:
    cmp al, 33
    jb bad
    cmp al, 126
    ja bad

    mov cx, [count]
    cmp cx, buffer_size
    jae buffer_full

    push ax
    inc [count]
    jmp read

bad:
    mov ah, 9
    mov dx, bad_msg
    int 21h
    jmp run

buffer_full:
    mov ah, 9
    mov dx, buffer_full_msg
    int 21h
    jmp process

process:
    mov cx, [count]
    cmp cx, 0
    je run

    mov di, buffer
    add di, cx
    dec di

store_loop:
    pop ax
    add al, 2
    mov [di], al
    dec di
    loop store_loop

print:
    mov bx, [count]
    mov byte [buffer + bx], '$'
    
    mov ah, 9
    mov dx, buffer
    int 21h
    
    jmp run

end:
    mov ax, 4c00h
    int 21h

section .data
bad_msg         db 10, 13, "Zly znak w wpisanym tekscie", 10, 13, "$"
buffer_full_msg db 10, 13, "Osiagnieto maksymalna dlugosc tekstu", 10, 13, "$"

com1    db "Program zwraca wprowadzony tekst, ktorego wartosc kodu ASCII kazdego znaku zostala powiekszona o 2.", 10, 13,"UWAGA: program przyjmuje znaki ktorych kod miesci sie w zakresie 33-126(dec)", 10, 13, "SPACJA = Koniec programu", 10, 13, "ENTER = Zakoncz wpisywanie tekstu", 10, 13, "$"
com2    db 10, 13, "Wpisz tekst: ", 10, 13, "$"

count       dw 0
buffer_size equ 60000
buffer      times buffer_size db 0
