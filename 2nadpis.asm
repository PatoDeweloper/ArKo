;Wpisaæ do rejestru wartoœæ sta³¹, a nastêpnie zaktualizowaæ jej wartoœæ (na dwa sposoby).

;pierwszy sposób, od razu do pamiêci
org 100h

start:

mov  byte   [liczba], 55 
mov	cx, [liczba]  ;tu wypisujemy zmienn¹ na ekran
mov	ah, 2
mov	dx, cx
int	21h

mov	ax, 4C00h
int	21h

liczba		dd	35