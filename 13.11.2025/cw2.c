#include <stdio.h>

int main()
{
    int number;

    printf( "Podaj liczbe: " );
    scanf_s( "%d", &number );
    printf( "Podales %d", number ); /* C function parameters are always "pass-by-value", which means that the function scanf only sees a copy of the current value of whatever you specify as the argument expression. In this case &i is a pointer value that refers to the variable i.  */
    getchar();
    return 0;
}