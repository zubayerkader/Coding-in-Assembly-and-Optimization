.string1:
	.string "Please enter your name: "
.string2:
	.string "Thank you %s!\n"
.string3:
	.string "Please enter your year of birth: "
.string4:
	.string "%ld is not a valid year.\n"
	
	.globl get_age
get_age:
	push %rbx
	push %rbp		# callee saved registers
				# local variables:
	leaq -8(%rsp), %rsp	#   - endptr
	leaq -24(%rsp), %rsp	#   - name_str[24]
	leaq -24(%rsp), %rsp	#   - year_of_birth[24]
	mov %rsp, %rbp

	movq $.string1, %rdi
	xorl %eax, %eax
	call printf# printf("Please enter your name: ");

	leaq 48(%rbp), %rdi
	call gets		# gets(name_str); saves the name in the 48 at the first word


	leaq 48(%rbp), %rsi	# rsi points the first letter of the string containg name
	movq $.string2, %rdi

	xorl %eax, %eax
	call printf		# printf("Thank you");

loop:

	movq $.string3, %rdi
	xorl %eax, %eax
	call printf		# printf(" Please enter your year of birth: ");

	leaq 24(%rbp), %rdi
	call gets

	mov %rax, %rdi

	leaq 56(%rbp), %rsi	# Moves to the top of the stack
	movq $0, %rdx		# Base of 10

	call strtol

	cmp $2014, %eax
	jg false_value

	cmp $1900, %eax
	jl false_value

	imul $(-1), %rax
	add $2017, %rax		#Outputs the age

	jmp endl

false_value:
	
	mov %rax, %rsi
	movq $.string4, %rdi
	xorl %eax, %eax
	call printf		# printf("not a valid year");
	jmp loop


endl:

	leaq 56(%rsp), %rsp
	pop %rbp
	pop %rbx

	ret

