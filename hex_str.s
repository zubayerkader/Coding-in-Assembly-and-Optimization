	.globl hex_str
hex_str:
	movb $48, (%rsi)	#put 0 in the string as first element
	incq %rsi		#move pointer to next element
	movb $120, (%rsi)	#put x in the string as second element

	addq $9, %rsi		#move pointer to the last element of the string
	movb $0, (%rsi)		#put null character in the last element
	dec %rsi		#move pointer to second last element
	movl $0, %ecx		#loop counter ecx = 0
	movl $0xf, %eax		#take a 32 bit register (eax) so that only the 4 bits are 1111

loop:
	mov %edi, %edx		#move integer parameter to scratch register
	and %eax, %edx		#and eax and edx to get only the last 4 bits of the parameter
	cmp $9, %edx		#edx - 9 ? 0
	jg else			#if edx - 9 > 0 jump to else
	add $48, %edx		#add 48 to edx so that it becomes the right charater from 0 - 9
	movb %dl, (%rsi)	#move the character to the string
	dec %rsi		#decrement pointer
	shrl $4, %edi		#shift edi left to get 0000 0000 0000 1111 0000 and so on
	inc %ecx		#increment count
	cmp $8, %ecx		#if count is >= 8 
	jge endloop		#then jump to endloop
	jmp loop		#else jump to loop

else:
	add $87, %edx		#add 48 to edx so that it becomes the right charater from a - f
	movb %dl, (%rsi)	#move the character to the string
	dec %rsi		#decrement pointer
	shrl $4, %edi		#shift edi left to get 0000 0000 0000 1111 0000 and so on
	inc %ecx		#increment count
	cmp $8, %ecx		#if count is >= 8
	jge endloop		#then jump to endloop
	jmp loop		#else jump to loop

endloop:
	ret			#return
