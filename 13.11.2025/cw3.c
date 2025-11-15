#include <stdio.h>	

int main()                            
{
    int wiek;                         /* Deklaruje zmienna calkowita, ktora bedzie przechowywac informacje o wieku uzytkownika tego programu*/
  
    printf( "Podaj swoj wiek" );  /* Prosi o wiek */
    scanf_s( "%d", &wiek );                 /* Informacja wejsciowa jest wsadzana do zmiennej wiek */
    if ( wiek < 100 ) {                  /* Jesli wiek jest mniejszy niz 100 */
        printf ("Jestes mlody!\n" ); 
    }
    else if ( wiek == 100 ) {            /* Jesli wiek jest rowny 100 */ 
        printf( "Jestes stary\n" );       
    }
    else {
        printf( "Jestes bardzo stary\n" );     /* program wyswietla ta informacje, gdy uzytkownik podaj informacje inna niz dwie powyzsze (czyli np. 110) */
    }
  return 0;
}