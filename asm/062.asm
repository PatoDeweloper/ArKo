; Program NASM 16-bit (.COM) – wyszukiwanie litery 'E' w buforze
org 100h

start:
    cld
    mov cx, tekst_len
    mov al, 'E'         ; szukany znak
    mov di, tekst
    repne scasb         ; szukaj a¿ znajdziesz 'E' lub CX=0
    jne brak
    mov dx, found
    jmp wypisz
brak:
    mov dx, notfound
wypisz:
    mov ah, 09h
    int 21h
    mov ax, 4C00h
    int 21h

tekst db 'TEST ASSEMBLER$', 0
tekst_len equ $ - tekst
found db 'Znak E znaleziony!$', 0
notfound db 'Brak znaku E.$', 0
