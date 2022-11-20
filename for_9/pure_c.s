	.file	"pure_c.c"
	.text
	.globl	my_stoi
	.type	my_stoi, @function
my_stoi:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, -40(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L2
.L3:
	movl	-24(%rbp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, -24(%rbp)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	$48, %eax
	addl	%eax, -24(%rbp)
	addl	$1, -20(%rbp)
.L2:
	movl	-20(%rbp), %eax
	movslq	%eax, %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	%rax, %rbx
	jb	.L3
	movl	-24(%rbp), %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.size	my_stoi, .-my_stoi
	.globl	f
	.type	f, @function
f:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movsd	%xmm0, -8(%rbp)
	movsd	.LC0(%rip), %xmm0
	movq	-8(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	.LC1(%rip), %xmm1
	addsd	%xmm1, %xmm0
	movq	.LC0(%rip), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	%xmm0, -16(%rbp)
	movsd	.LC0(%rip), %xmm0
	movq	-8(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	addsd	-16(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	subsd	%xmm1, %xmm0
	leave
	ret
	.size	f, .-f
	.globl	sign
	.type	sign, @function
sign:
	pushq	%rbp
	movq	%rsp, %rbp
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comisd	%xmm1, %xmm0
	jbe	.L13
	movsd	.LC1(%rip), %xmm0
	jmp	.L11
.L13:
	movsd	.LC4(%rip), %xmm0
.L11:
	popq	%rbp
	ret
	.size	sign, .-sign
	.globl	bisection_solution
	.type	bisection_solution, @function
bisection_solution:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movsd	%xmm0, -40(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -24(%rbp)
	movsd	.LC1(%rip), %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L15
.L18:
	movsd	-16(%rbp), %xmm0
	subsd	-24(%rbp), %xmm0
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	-24(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %xmm0
	call	f
	call	sign
	movsd	%xmm0, -48(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %xmm0
	call	f
	call	sign
	movsd	-48(%rbp), %xmm2
	ucomisd	%xmm0, %xmm2
	jp	.L20
	ucomisd	%xmm0, %xmm2
	je	.L21
.L20:
	movsd	-8(%rbp), %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L15
.L21:
	movsd	-8(%rbp), %xmm0
	movsd	%xmm0, -24(%rbp)
.L15:
	movsd	-16(%rbp), %xmm0
	subsd	-24(%rbp), %xmm0
	comisd	-40(%rbp), %xmm0
	ja	.L18
	movsd	-8(%rbp), %xmm0
	leave
	ret
	.size	bisection_solution, .-bisection_solution
	.globl	random_eps
	.type	random_eps, @function
random_eps:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$1441166293, %rdx, %rdx
	shrq	$32, %rdx
	movl	%edx, %ecx
	sarl	$25, %ecx
	cltd
	subl	%edx, %ecx
	movl	%ecx, %edx
	imull	$99999000, %edx, %edx
	subl	%edx, %eax
	movl	%eax, %edx
	leal	1000(%rdx), %eax
	cvtsi2sdl	%eax, %xmm1
	movsd	.LC1(%rip), %xmm0
	divsd	%xmm1, %xmm0
	popq	%rbp
	ret
	.size	random_eps, .-random_eps
	.section	.rodata
.LC5:
	.string	"r"
.LC6:
	.string	"w"
.LC7:
	.string	"%lf"
.LC8:
	.string	"%.10lf\n"
.LC9:
	.string	"-r"
.LC11:
	.string	"%.30lf\n"
.LC12:
	.string	"Invalid input"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$3, -52(%rbp)
	jne	.L25
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L26
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -16(%rbp)
	leaq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	leaq	.LC7(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %xmm0
	call	bisection_solution
	movq	-16(%rbp), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	jmp	.L31
.L26:
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC9(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L28
	movl	$0, %eax
	call	random_eps
	movq	%xmm0, %rax
	movq	%rax, -40(%rbp)
	movq	-64(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	my_stoi
	movl	%eax, -44(%rbp)
	call	clock@PLT
	movq	%rax, -24(%rbp)
	movl	$0, -48(%rbp)
	jmp	.L29
.L30:
	movq	-40(%rbp), %rax
	movq	%rax, %xmm0
	call	bisection_solution
	addl	$1, -48(%rbp)
.L29:
	movl	-48(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L30
	call	clock@PLT
	subq	-24(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC10(%rip), %xmm1
	divsd	%xmm1, %xmm0
	leaq	.LC11(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	jmp	.L31
.L28:
	leaq	.LC12(%rip), %rdi
	call	puts@PLT
	jmp	.L31
.L25:
	leaq	.LC12(%rip), %rdi
	call	puts@PLT
.L31:
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L33
	call	__stack_chk_fail@PLT
.L33:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1073741824
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	1074790400
	.align 8
.LC4:
	.long	0
	.long	-1074790400
	.align 8
.LC10:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
