#include <stdio.h>

int main()
{
    int x;
    /* Petla przechodzona jest przez x < 10, zas x rosnie z kazdym kolejny przejsciem petli*/
    for ( x = 0; x < 10; x++ ) { 
        printf( "%d\n", x ); /* program kolejno wyswietla zawartosc zmiennej x, od 0 do 9; gdy x=10 nastepuje wyjscie z petli*/
    }
    getchar();
}