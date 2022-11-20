	.file	"pure_c.c"
	.text
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
	jbe	.L9
	movsd	.LC1(%rip), %xmm0
	jmp	.L7
.L9:
	movsd	.LC4(%rip), %xmm0
.L7:
	popq	%rbp
	ret
	.size	sign, .-sign
	.section	.rodata
.LC5:
	.string	"%lf"
	.text
	.globl	bisection_solution
	.type	bisection_solution, @function
bisection_solution:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -32(%rbp)
	movsd	.LC1(%rip), %xmm0
	movsd	%xmm0, -24(%rbp)
	leaq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	jmp	.L11
.L14:
	movsd	-24(%rbp), %xmm0
	subsd	-32(%rbp), %xmm0
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	-32(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %xmm0
	call	f
	call	sign
	movsd	%xmm0, -56(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %xmm0
	call	f
	call	sign
	movsd	-56(%rbp), %xmm2
	ucomisd	%xmm0, %xmm2
	jp	.L17
	ucomisd	%xmm0, %xmm2
	je	.L18
.L17:
	movsd	-16(%rbp), %xmm0
	movsd	%xmm0, -24(%rbp)
	jmp	.L11
.L18:
	movsd	-16(%rbp), %xmm0
	movsd	%xmm0, -32(%rbp)
.L11:
	movsd	-24(%rbp), %xmm0
	subsd	-32(%rbp), %xmm0
	movsd	-40(%rbp), %xmm1
	comisd	%xmm1, %xmm0
	ja	.L14
	movsd	-16(%rbp), %xmm0
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L16
	call	__stack_chk_fail@PLT
.L16:
	leave
	ret
	.size	bisection_solution, .-bisection_solution
	.section	.rodata
.LC6:
	.string	"%.10lf\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %eax
	call	bisection_solution
	leaq	.LC6(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	popq	%rbp
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
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
