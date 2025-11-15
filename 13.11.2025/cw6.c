#include <stdio.h>

int main()
{ 
    int x;            /* Deklaracji liczby calkowitej*/
    int *p;           /* Wskaznik do liczby calkowitej ("*p" jest integerem, wiec p musi 							wskazywac na integer) */

    p = &x;           /* Przypisz adres x do p*/
    scanf_s( "%d", &x );          /* Wstaw wartosc do x (p tez moze byc) */
    printf( "%d\n", *p ); /* Skorzystanie z * w celu odzywakania wartosci pobranej z 						klawiatury */
    getchar();
}