; Program NASM 16-bit (.COM) – kopiowanie tekstu za pomoc¹ MOVSB i REP
org 100h

start:
    cld                 ; DF=0 › przetwarzanie od pocz¹tku
    mov cx, tekst_len   ; liczba bajtów do skopiowania
    mov si, tekst_src   ; Ÿród³o danych (DS:SI)
    mov di, tekst_dst   ; cel danych (ES:DI)
    rep movsb           ; powtarzaj MOVSB, a¿ CX=0
    
    mov dx, tekst_dst
    mov ah, 09h
    int 21h             ; wyœwietl skopiowany tekst
    
    mov ax, 4C00h
    int 21h

tekst_src db 'Kopiowanie udane!$', 0
tekst_len equ $ - tekst_src
tekst_dst times 32 db '$'
