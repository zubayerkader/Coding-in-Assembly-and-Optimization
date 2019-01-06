	.globl times	#given: edi = a, esi = b, eax = result
times:			
	mov $0, %eax	#result = 0
	mov $0, %rcx	#rcx = i = 0
loop:			
	cmp %rsi, %rcx	#rcx - rsi ? 0  --->  i - b ? 0
	jge endloop	#rcx - rsi >= 0 --->  if (i >= b) return result
	add %edi, %eax	#eax += edi     --->  result += a
	inc %rcx	#rcx++		--->  i++
	jmp loop	#		--->  loop again
endloop:
	ret		#return eax     --->  return result after loop is done, ie: if (i >= b)

