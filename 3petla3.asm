;Wykonaæ arytmetykê na rejestrach: zadeklarowaæ tablicê znaków drukowalnych i po kolei je wyœwietlaæ.

org 100h

mov cx, 4
mov bx, 0

start:

mov   ah, 2
mov   dx, [xxx] ;wypisze "6", xxx+2 wypisze "5" itd.
sub   dx, bx
add   bx, 1
dec   cx
int   21h
jnz   start

mov   ax, 4C00h
int   21h

xxx         db    55,54,53,52