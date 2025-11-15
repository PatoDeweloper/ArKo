org 100h
start:
	mov bl, 5
	mov al, [liczba]
	mul bl
	add ax, bx 
	
	
	

        mov bl,10       ; dzielinik 

        div bl           



        mov ch,ah       ; przepisanie reszty z dzielenia przez 10

        mov ah,0        ; wpisanie 0 do mlodszej czesci

        div bl          ; dzielenie przez 10

        mov cl,ah       ; przepisanie reszty do nowego wolnego rejestru

                        ; do cl w al jest najstarsza 

        add al,"0"      

        mov dl,al       

        mov ah,2        

        int 21h         



        add cl,"0"      

        mov dl,cl

        mov ah,2

        int 21h



        add ch,"0"      

        mov dl,ch

        mov ah,2

        int 21h
	
	
	

	

mov	ax, 4C00h
int	21h


liczba		db 80