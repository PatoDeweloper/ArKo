;Program do wypisywania znaków na ekranie w odwrotnej kolejnoœci, w jakiej by³y wprowadzone z klawiatury. Wykorzystuje stos
org 100h

start:
	xor 	ax,ax
	xor 	dx,dx
	mov	ah, 1
	xor		cx,cx
pobieranie: ;tu w pêtli pobieramy znaki z wejœcia, dopóki nie napotkamy na ENTER
	int	21h
	cmp		al,13
	jz	popetli ;wyjœcie z pêtli, jeœli ENTER
	push	ax	
	inc 	cx
	jmp 	pobieranie 
popetli: ;tu sekcja wypisania ENTERA na ekranie (¿eby by³o widaæ stary i nowy napis)
	mov		ah, 2			
	mov 	dx, [nowalinia]
	int 	21h
	mov 	dx, [nowalinia+1]
	int 21h
wypisywanie: ;pêtla wypisywania na ekranie znaków w odwrotnej kolejnoœci
	pop		dx
	int	21h
	loop 	wypisywanie

	mov		ax, 4C00h
	int	21h

	nowalinia db 10,13 ;powrót karetki i nowa linia; powrot karetki "carriage return" to ci¹g dwóch znaków o wartoœciach ascii równych 10 i 13 (szesnastkowo 0x0A i 0x0D), oznaczaj¹cy koniec bie¿¹cej linii tekstu. "Powrót karetki" to okreslenie bêd¹ce reliktem mechanicznych maszyn do pisania, gdzie aby zacz¹æ now¹ liniê, najpierw nale¿a³o przesun¹æ karetkê (okienko, gdzie uderza³y czcionki) do lewego marginesu , a póŸniej przesun¹æ papier o jedn¹ liniê do góry. W ró¿nych systemach operacyjnych do oznaczania koñca linii wykorzystuje siê ró¿ne znaki. Np. w Unixach, BeOS lub AmigaOS do tego s³u¿y znak LF. W systemach DOS, OS/2, Symbian, MS Windows wykorzystuje siê znak CRLF, zaœ w systemach Commodore, Apple II, Mac OS (do wersji 9) korzysta siê ze znaku CR. 