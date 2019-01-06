	# rdi - int *A
	# esi - int n
	# rdx - int target
	# eax - int index
	# r9d - int temp
	# r8  - i
	# ecx - count


	.globl	lsearch_2

lsearch_2:

	testl	%esi, %esi		# if(n<=0){
	js	wrongsize		# index=-1; return index;}
	movslq	%esi, %rax		# index=n
	leaq	-4(%rdi,%rax,4), %rax	# index=*A+(n-1)
	movl	(%rax), %r9d		# temp = *(index)
	movl	%edx, (%rax)		# A[n-1]= target
	cmpl	(%rdi), %edx		# if (A[1]==target)
	je	index1			# {	count=0;
	movl	$0, %ecx		#	index = n-1;
					#	if (index>count) {index=count; return index;}
					# }
loop:
	addl	$1, %ecx		# count=0;
	movslq	%ecx, %r8		# do {
	cmpl	(%rdi,%r8,4), %edx	# count++;
	jne	loop			# int i=count;
	jmp	if			# if (A[i] != target)
index1:				
	movl	$0, %ecx
if:
	movl	%r9d, (%rax)		# *index=temp;
	leal	-1(%rsi), %eax		# index=n-1
	cmpl	%ecx, %eax		# if (index>count) {index = count; return index}
	jg	index			
	cmpl	%edx, %r9d		# else if (index != temp)
	movl	$-1, %edx		# { n=1;
	cmovne	%edx, %eax		#	index = n;
	ret				# }return index;
wrongsize:
	movl	$-1, %eax
	ret
index:
	movl	%ecx, %eax
	ret


