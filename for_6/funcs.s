	.text
        .globl  f
        .type   f, @function
f:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $48, %rsp

	movsd	%xmm1, 24(%rsp)		# сохраняем нужные регистры на стеке, чтобы вернуть их
	movsd   %xmm2, 16(%rsp)		# обратно в функцию bisection_solution в исходном состоянии
	movsd   %xmm3, 8(%rsp)
	movsd   %xmm5, (%rsp)

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

        movsd   24(%rsp), %xmm1
        movsd   16(%rsp), %xmm2
        movsd   8(%rsp), %xmm3
        movsd   (%rsp), %xmm5

        movq    %rbp, %rsp
        popq    %rbp
        ret
        .size   f, .-f

sign:
        pushq   %rbp
        movq    %rsp, %rbp
	subq	$16, %rsp

	movsd	%xmm1, (%rsp)		# сохраняем регистр на стеке, чтобы вернуть функции 
					# bisection_solution в исходном состоянии

        pxor    %xmm1, %xmm1
        comisd  %xmm1, %xmm0            # сравниваем x с 0
        jbe     .bad                    # если <= 0, то .LC4(-1.0) -> %xmm0
        movsd   .LC1(%rip), %xmm0       # иначе, то .LC1(1.0) -> %xmm0
        jmp     .end_of_sign
.bad:
        movsd   .LC4(%rip), %xmm0

.end_of_sign:
	movsd	(%rsp), %xmm1

	movq	%rbp, %rsp
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
        subq    $16, %rsp

        leaq    .LC5(%rip), %rdi
        leaq    (%rsp), %rsi		# (%rsp) = eps
	movq    $0, %rax
        call    __isoc99_scanf@PLT

        pxor    %xmm1, %xmm1		# %xmm1 = x_n = 0.0
        movsd   .LC1(%rip), %xmm2	# %xmm2 = x_k = 1.0
        jmp     .while_cond
	.while:
        movapd	%xmm2, %xmm7		# x_k -> %xmm7
        subpd   %xmm1, %xmm7		# x_k - x_n -> %xmm7
        movsd   .LC0(%rip), %xmm4	# 2.0 -> %xmm4
        divpd   %xmm4, %xmm7		# (x_k - x_n) / 2.0 -> %xmm7
        movapd  %xmm1, %xmm4		# x_n -> %xmm4
        addpd   %xmm4, %xmm7		# x_n + (x_k - x_n) / 2.0 -> %xmm7
        
	movapd  %xmm7, %xmm3		# %xmm3 = x_i
        movapd  %xmm1, %xmm0		# x_n -> %xmm0
        call    f
        call    sign
	movapd  %xmm0, %xmm5		# sign(f(x_n)) -> %xmm0

        movapd  %xmm3, %xmm0
        call    f
        call    sign
        ucomisd %xmm0, %xmm5
        
	jp      .inequal
        ucomisd %xmm0, %xmm5
        je      .equal
.inequal:
        movapd	%xmm3, %xmm2		# x_k = x_i
        jmp     .while_cond
.equal:
	movapd	%xmm3, %xmm1		# x_n = x_i
.while_cond:
        movapd	%xmm2, %xmm0
        subpd	%xmm1, %xmm0
        movsd   (%rsp), %xmm4
        comisd  %xmm4, %xmm0
        ja      .while

        movapd	%xmm3, %xmm0
        movq    %rbp, %rsp
        popq    %rbp
        ret
        .size   bisection_solution, .-bisection_solution

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
