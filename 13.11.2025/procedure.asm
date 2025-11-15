	section .text use32 ; use32 to uzycie kodu 32 bitowego 
	global	_sum ; _sum to konwencja przyjeta w niektorych kompilatorach c; 

	_sum:
	; po wykonaniu push ebp i mov ebp, esp:
	; [ebp]    stara lokacja EBP
	; [ebp+4]  punkt powrotu z procedury
	; [ebp+8]  pierwszy parametr procedury
	; [ebp+12] drugi parametr procedury 

	%idefine	a	[ebp+8] ; dyrektywa definiujaca stala
	%idefine	b	[ebp+12]

		push	ebp ; tworze ramke stosu
		mov	ebp, esp ; 

		mov	eax, a
		add	eax, b

	; LEAVE = mov esp, ebp / pop ebp
		leave
		ret