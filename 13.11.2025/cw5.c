#include <stdio.h>

int mult(int x, int y);

int main()
{
	int x;
	int y;

	printf("Wpisz dwie liczby do wymnozenia: ");
	scanf_s("%d", &x);
	scanf_s("%d", &y);
	printf("Wynikiem mnozenia dwoch podanych przez ciebie liczb jest %d\n", mult(x, y));
	getchar();
}

int mult(int x, int y)
{
	return x * y;
}