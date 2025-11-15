#include <stdio.h>
#include <stdlib.h>


int main()
{
    printf("Wpisz dwie wartosci a nastepnie operacje (+-*/)\n");
    float x, y;
    char znak;
    float wynik;
    scanf(" %f", &x);
    scanf(" %f", &y);
    scanf(" %c", &znak);
    if(znak=='+')
    {
        wynik=x+y;
        printf("Wynik tej operacji to: %f\n", wynik);
    }
    else if(znak=='-')
    {
        wynik=x-y;
        printf("Wynik tej operacji to: %f\n", wynik);
    }
    else if(znak=='*')
    {
        wynik=x*y;
        printf("Wynik tej operacji to: %f\n", wynik);
    }
    else if(znak=='/')
    {
        wynik=x/y;
        printf("Wynik tej operacji to: %f\n", wynik);
    }
    else
    {
        printf("Podano zla operacje arytmetyczna!!!");
    }
}

