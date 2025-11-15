#include <stdio.h> /* plik nagłówkowy stdio.h, który zawiera informacje na temat standardowego wejścia i wyjścia (standard input / output). */

	extern int _sum (int a, int b); /* deklaracja funkcji zewnetrznej*/

	int sum (int a, int b);	 /* prototyp funkcji; informuje kompilator o tym, jakiego typu jest dana funkcja oraz jakiego typu parametry przyjmuje */

	int c=1, d=2;

	int main()
	{ 					/* miedzy klamrami jest cialo funkcji*/
		printf("%d\n", sum(c,d));
		return 0; /*  funkcja main powinna zwracać wartość do miejsca wywołania (system operacyjny) */
	}