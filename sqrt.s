	.globl sqrt

sqrt:
				
	mov	$0, %eax   		# result = 0	
	cmp 	%eax, %edi			
	je 	endl			# result= 0 if input is 0
	
	mov 	$15, %ecx		
	mov 	$0x8000, %edx	
	mov 	$0, %esi	
	
forloop: 	
	cmp	$0, %ecx       		 # for (int i = 15; i < 0; i--)
	jl	endl
	dec 	%ecx		
	
	or	%edx , %eax	
	mov	%eax , %esi	
	imul 	%esi, %esi    		# result * result 
	cmp 	%esi, %edi		# comparing the result with x 
	jl	else			# if the result > x then else
	shr 	$1  , %edx		# divide the value by 2
	jmp	forloop		

else:
	
	xor	%edx, %eax 	
	shr 	$1   , %edx	 	# divide the value by 2
	jmp 	forloop
	
endl:
	ret
