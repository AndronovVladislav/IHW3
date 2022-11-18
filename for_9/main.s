	.section .rodata
	.LC6:
        	.string "%.10lf\n"
	.write_random:
		.string "%.30lf\n"
	.read_mode:
		.string "r"
	.write_mode:
		.string "w"
	.scan_eps:
		.string "%lf"
	.random:
		.string "-r"
	.CLOCKS_PER_SEC:
        	.long   0
        	.long   1093567616
	.bad_input:
		.string "Invalid input\n"
        	.text
        	.globl  main
        	.type   main, @function
main:
        pushq   %rbp
        movq    %rsp, %rbp
	pushq	%r12
	pushq	%r13
	pushq	%rbx

	subq	$24, %rsp

	movq	%rdi, %r12
	movq	%rsi, %r13

	addq	$8, %rsi
	movq	(%rsi), %rdi
	leaq	.read_mode(%rip), %rsi
	call 	fopen@PLT
	movq	%rax, (%rsp)		# (%rsp) - file_in

	movq	%r13, %rdi

	addq	$16, %rdi
	movq	(%rdi), %rdi
	leaq	.write_mode(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 8(%rsp)		# 8(%rsp) - file_out

	.if:
	cmp	$3, %r12
	jne	.else_if
	cmp	$0, (%rsp)
	je	.else_if

	movq	(%rsp), %rdi
	leaq	.scan_eps(%rip), %rsi
	leaq	16(%rsp), %rdx
	call	fscanf@PLT

	movsd	16(%rsp), %xmm0
	call	bisection_solution

	movq	8(%rsp), %rdi
	leaq	.LC6(%rip), %rsi
	call	fprintf@PLT

	movq	(%rsp), %rdi
	call	fclose@PLT

	jmp	.common_end
	.else_if:
	cmp	$3, %r12
	jne	.else

	movq	%r13, %rdi
	addq	$8, %rdi
	movq	(%rdi), %rdi
	leaq	.random(%rip), %rsi
	call	strcmp@PLT
	cmp	$0, %rax
	jne	.else

	call	random_eps
	movsd	%xmm0, 16(%rsp)	

 	call    clock@PLT
        mov     %rax, %rbx

	movsd	16(%rsp), %xmm0
	call	bisection_solution
	movsd	%xmm0, 16(%rsp)

	call	clock@PLT
	pxor	%xmm0, %xmm0
	
	leaq	.write_random(%rip), %rdi
	
	subq	%rbx, %rax
	cvtsi2sd %rax, %xmm0
	movq	$1, %rax
	divsd	.CLOCKS_PER_SEC(%rip), %xmm0
	call	printf@PLT

        movq    8(%rsp), %rdi
        leaq    .LC6(%rip), %rsi
        call    fprintf@PLT
	jmp	.common_end	
	
	.else:
	leaq	.bad_input(%rip), %rdi
	call	printf@PLT

	.common_end:
	movq	8(%rsp), %rdi
	call	fclose@PLT

	addq	$24, %rsp
	popq	%rbx
	popq	%r13
	popq	%r12
	movq	%rbp, %rsp
	popq	%rbp
        ret
        .size   main, .-main
