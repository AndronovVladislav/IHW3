	.text
        .globl  f
        .type   f, @function
f:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $16, %rsp

	movsd	%xmm0, -8(%rbp)		# -8(%rbp) = x
	
	movsd	.LC0(%rip), %xmm1
	call	pow@PLT
	movapd	%xmm0, %xmm4		# %xmm4 = pow(x, 2.0)
	
	movsd	.LC1(%rip), %xmm1
	addsd	%xmm1, %xmm4		# %xmm4 = pow(x, 2.0) + 1

	movsd	.LC0(%rip), %xmm0
	movapd	%xmm4, %xmm1
	call	pow@PLT
	movapd	%xmm0, %xmm3		# %xmm3 = pow(2.0, pow(x, 2.0) + 1)
	
	movsd	-8(%rbp), %xmm0
	movsd	%xmm3, -8(%rbp)
	movsd	.LC0(%rip), %xmm1
	call	pow@PLT
	movsd	-8(%rbp), %xmm1
	addsd	%xmm0, %xmm1		# %xmm1 = pow(2.0, pow(x, 2.0) + 1) + pow(x, 2.0)

	movsd	.LC2(%rip), %xmm0
	subsd	%xmm0, %xmm1		# %xmm1 = pow(2.0, pow(x, 2.0) + 1) + pow(x, 2.0) - 4

	movapd	%xmm1, %xmm0

        movq    %rbp, %rsp
        popq    %rbp
        ret
        .size   f, .-f

	.globl	sign
	.type	sign, @function
sign:
        pushq   %rbp
        movq    %rsp, %rbp
        pxor    %xmm1, %xmm1
        comisd  %xmm1, %xmm0            # сравниваем x с 0
        jbe     .bad                     # если <= 0, то .LC4(-1.0) -> %xmm0
        movsd   .LC1(%rip), %xmm0       # иначе, то .LC1(1.0) -> %xmm0
        jmp     .end_of_sign
.bad:
        movsd   .LC4(%rip), %xmm0
.end_of_sign:
        popq    %rbp
        ret
        .size   sign, .-sign

        .section        .rodata
.LC5:
        .string "%lf"
        .text
        .globl  bisection_solution
        .type   bisection_solution, @function
bisection_solution:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $64, %rsp

	movq	%xmm0, -40(%rbp)

        pxor    %xmm0, %xmm0
        movsd   %xmm0, -32(%rbp)	# -32(%rbp) = x_n
        movsd   .LC1(%rip), %xmm0
        movsd   %xmm0, -24(%rbp)	# -24(%rbp) = x_k

        jmp     .while_cond
.while:
        movsd   -24(%rbp), %xmm0
        subsd   -32(%rbp), %xmm0
        movsd   .LC0(%rip), %xmm1
        divsd   %xmm1, %xmm0
        movsd   -32(%rbp), %xmm1
        addsd   %xmm1, %xmm0
        
	movsd   %xmm0, -16(%rbp)
        movq    -32(%rbp), %rax
        movq    %rax, %xmm0
        call    f
        call    sign
        
	movsd   %xmm0, -56(%rbp)
        movq    -16(%rbp), %rax
        movq    %rax, %xmm0
        call    f
        call    sign
        movsd   -56(%rbp), %xmm2
        ucomisd %xmm0, %xmm2
        
	jp      .inequal
        ucomisd %xmm0, %xmm2
        je      .equal
.inequal:
        movsd   -16(%rbp), %xmm0
        movsd   %xmm0, -24(%rbp)
        jmp     .while_cond
.equal:
        movsd   -16(%rbp), %xmm0
        movsd   %xmm0, -32(%rbp)
.while_cond:
        movsd   -24(%rbp), %xmm0
        subsd   -32(%rbp), %xmm0
        movsd   -40(%rbp), %xmm1
        comisd  %xmm1, %xmm0
        ja      .while

        movsd   -16(%rbp), %xmm0
        movq    %rbp, %rsp
        popq    %rbp
        ret
        .size   bisection_solution, .-bisection_solution
	
	.text
        .globl  random_eps
        .type   random_eps, @function
random_eps:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$0, %rdi
	call	time@PLT
	movq	%rax, %rdi
	call	srand@PLT
	call	rand@PLT
	movq	$10000, %rcx
	xorq	%rdx, %rdx
	divq	%rcx, %rax

	cvtsi2sd %rdx, %xmm1
	movsd	.LC1(%rip), %xmm0
	divsd	%xmm1, %xmm0

	movq	%rbp, %rsp
	popq	%rbp
	ret

	.section        .rodata
        .align 8
.LC0:
        .long   0
        .long   1073741824      # 2.0
        .align 8
.LC1:
        .long   0
        .long   1072693248      # 1.0
        .align 8
.LC2:
        .long   0
        .long   1074790400      # 4.0
        .align 8
.LC4:
        .long   0
        .long   -1074790400     # -1.0
