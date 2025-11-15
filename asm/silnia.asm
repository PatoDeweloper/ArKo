org 100h

section.text
	start:
	
	mov cx, num
	num_stack:
		push cx
		dec cx
		jnz num_stack
	
	
	

section.data
	num db 4