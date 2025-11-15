; ------------------------------------------------------------
;  Program: stack_demo.asm
;  Cel: Demonstracja dzia³ania stosu (PUSH, POP, adresowanie, bufor)
;  Architektura: 16-bit x86, program .COM (DOS)
; ------------------------------------------------------------
;  Sposób kompilacji:
;       nasm -f bin stack.asm -o stack.com
; ------------------------------------------------------------

org 100h             ; Punkt startowy dla programów .COM (100h to pocz¹tek kodu)

start:

    ; ========================================================
    ; 1) USTAWIENIE STOSU (SS:SP)
    ; --------------------------------------------------------
    ; W programach .COM DOS domyœlnie ustawia SS = CS, SP ? 0xFFFE,
    ; ale tutaj robimy to jawnie, ¿eby pokazaæ jak wygl¹da poprawna inicjalizacja.
    ; CLI/ STI (Clear/Set Interrupt Flag) blokuje przerwania, ¿eby w œrodku
    ; ustawiania SS i SP nie wesz³o przerwanie i nie zapisa³o czegoœ w z³ym miejscu.
    ; ========================================================
    cli                    ; Wy³¹cz przerwania
    mov ax, cs             ; Pobierz aktualny segment kodu
    mov ss, ax             ; SS = CS › stos w tym samym segmencie co kod
    mov sp, 0FFFEh         ; SP = 0xFFFE › szczyt stosu (parzysty adres)
    sti                    ; W³¹cz ponownie przerwania

    ; ========================================================
    ; 2) PODSTAWOWE PUSH/POP
    ; --------------------------------------------------------
    ; PUSH odk³ada s³owo (2 bajty) na stosie:
    ;   SP = SP - 2
    ;   [SS:SP] = wartoœæ
    ; POP odwrotnie:
    ;   rejestr = [SS:SP]
    ;   SP = SP + 2
    ; ========================================================
    mov ax, 1234h          ; AX = 1234h
    mov bx, 5678h          ; BX = 5678h

    push ax                ; SP -= 2, [SS:SP] = 1234h
    push bx                ; SP -= 2, [SS:SP] = 5678h
    ; teraz na stosie (od góry): BX=5678h, AX=1234h

    pop  bx                ; BX = 5678h (SP += 2)
    pop  ax                ; AX = 1234h (SP += 2)
    ; po POP-ach SP wróci³o do pierwotnej wartoœci

    ; ========================================================
    ; 3) ZAMIANA ZAWARTOŒCI REJESTRÓW PRZEZ STOS
    ; --------------------------------------------------------
    ; Czasem chcemy zamieniæ zawartoœæ AX - BX bez u¿ycia instrukcji XCHG.
    ; Mo¿na to zrobiæ przez stos, odk³adaj¹c obie wartoœci i zdejmuj¹c w odwrotnej kolejnoœci.
    ; ========================================================
    push ax                ; [SS:SP-2] = AX (SP -= 2)
    push bx                ; [SS:SP-2] = BX (SP -= 2)
    pop  ax                ; AX = BX (SP += 2)
    pop  bx                ; BX = AX (SP += 2)
    ; W efekcie AX i BX zosta³y zamienione

    ; ========================================================
    ; 4) LOKALNY „BUFORY” NA STOSIE BEZ PROCEDUR
    ; --------------------------------------------------------
    ; Czasem potrzebujemy szybko przechowaæ wartoœæ „tymczasowo”,
    ; nie u¿ywaj¹c dodatkowych rejestrów.
    ; Mo¿emy po prostu przesun¹æ SP o trochê ni¿ej i traktowaæ te bajty jak pamiêæ.
    ; Ale UWAGA: nie mo¿na adresowaæ [SP], wiêc trzeba u¿yæ rejestru poœredniego (np. BX).
    ; ========================================================
    sub sp, 2              ; SP = SP - 2 › rezerwujemy 2 bajty na „lokalkê”
    mov bx, sp             ; BX = SP (adres nowego miejsca na stosie)
    mov word [ss:bx], 0BEEFH ; Zapisz wartoœæ 0xBEEF w to miejsce na stosie
    mov cx, [ss:bx]        ; Odczytaj tê sam¹ wartoœæ do rejestru CX (CX = 0xBEEF)
    add sp, 2              ; SP = SP + 2 › zwalniamy ten bufor (stos wraca)

    ; ========================================================
    ; 5) PUSHF / POPF
    ; --------------------------------------------------------
    ; PUSHF odk³ada na stos 16-bitow¹ kopiê rejestru FLAGS.
    ; POPF przywraca FLAGS ze stosu.
    ; Czêsto u¿ywane do tymczasowego zachowania flag (np. Carry, Zero, itp.)
    ; ========================================================
    pushf                  ; SP -= 2, [SS:SP] = FLAGS
    ; ... (tutaj mo¿na by coœ zmieniaæ) ...
    popf                   ; FLAGS = [SS:SP], SP += 2

    ; ========================================================
    ; 6) WYŒWIETLENIE WIADOMOŒCI W DOS
    ; --------------------------------------------------------
    ; Int 21h, funkcja 09h: wypisuje tekst, dopóki nie znajdzie znaku '$'
    ; DX › offset tekstu
    ; AH › 09h
    ; ========================================================
    mov dx, msg            ; DX = adres tekstu (offset w segmencie CS)
    mov ah, 09h            ; AH = 09h › funkcja "display string"
    int 21h                ; wywo³anie przerwania DOS › wypisuje tekst

    ; ========================================================
    ; 7) WYJŒCIE Z PROGRAMU DO DOS
    ; --------------------------------------------------------
    ; Int 21h, funkcja 4Ch – zakoñczenie programu
    ; AX = 4C00h › kod powrotu 0
    ; ========================================================
    mov ax, 4C00h
    int 21h

; ============================================================
; DANE
; ------------------------------------------------------------
; Tekst zakoñczony znakiem '$' (wymagany przez funkcjê 09h DOS-a)
; ============================================================
msg db 'Stos dziala bez procedur. PUSH/POP, swap i lokalny bufor OK.$'
