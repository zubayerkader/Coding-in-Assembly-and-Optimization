	.globl sum_float

	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer)
	#   %rsi:   n
	#   %rbp:   endptr

sum_float:
	push	%rbp
    push	%rsp
    addq	%rsi, %rsp
	xorps	%xmm0, %xmm0            # total <- 0.0
	leaq	(%rdi, %rsi, 4), %rbp   # endptr <- F + n
    movq	$0, %rcx                # i=0
loop:
    cmpq	%rdi, %rbp
    jle	endloop                 # while (F < endptr) {
    movq	(%rdi), %rbx
    addq	$4, %rdi
    minss	(%rbx, %rdi)

    addss	(%rdi), %xmm0       #   total += F[0]
    add	$4, %rdi                #   F++
    jmp	loop                    #  }


endloop:
    pop	%rbp
    pop     %rsp
    ret
