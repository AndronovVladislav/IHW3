	.section .rodata
	.LC6:
        	.string "%.10lf\n"
	.write_time:
		.string "%.30lf\n"
	.read_mode:
		.string "r"
	.write_mode:
		.string "w"
	.scan_eps:
		.string "%lf"
	.random:
		.string "-r"
	.debug:
		.string "%d\n"
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

	movq	%rdi, %r12		# %r12 = argc
	movq	%rsi, %r13		# %r13 = argv

	.if_argc_equal_3:
	cmp	$3, %r12		# if (argc == 3)
	jne	.else

        addq    $8, %rsi
        movq    (%rsi), %rdi		# %rdi = argv[1]
        leaq    .read_mode(%rip), %rsi
        call    fopen@PLT
        movq    %rax, (%rsp)            # (%rsp) - file_in

	cmp	$0, %rax		# if (file_in != NULL)
	je	.else_if

        movq    %r13, %rdi

        addq    $16, %rdi
        movq    (%rdi), %rdi		# %rdi = argv[2]
        leaq    .write_mode(%rip), %rsi
        call    fopen@PLT
        movq    %rax, 8(%rsp)           # 8(%rsp) - file_out

	movq	(%rsp), %rdi
	leaq	.scan_eps(%rip), %rsi
	leaq	16(%rsp), %rdx
	call	fscanf@PLT		# считываем eps из файла file_in в 16(%rsp)

	movsd	16(%rsp), %xmm0
	call	bisection_solution

	movq	8(%rsp), %rdi
	leaq	.LC6(%rip), %rsi
	call	fprintf@PLT		# печатаем результат вычислений в file_out

	movq	(%rsp), %rdi		# закрываем оба файла
	call	fclose@PLT

        movq    8(%rsp), %rdi
        call    fclose@PLT

	jmp	.common_end
	.else_if:
	movq	%r13, %rdi
	addq	$8, %rdi
	movq	(%rdi), %rdi
	leaq	.random(%rip), %rsi
	call	strcmp@PLT
	cmp	$0, %rax		# if (strcmp(argv[1], "-r") == 0)
	jne	.else

	call	random_eps
	movsd	%xmm0, 16(%rsp)		# 16(%rsp) = eps

 	movq	%r13, %rdi
	addq	$16, %rdi
	movq	(%rdi), %rdi
	call	my_stoi			# конвертируем заданное пользователем количество
	movq	%rax, %r12              # итераций из строки в число

	call    clock@PLT		# начало отсчёта
        mov     %rax, %rbx

	movq	$0, %r13
	.for:
	movsd	16(%rsp), %xmm0
	call	bisection_solution
	
	.for_check_cond:
	incq	%r13
	cmp	%r13, %r12
	jg	.for

	call	clock@PLT		# конец отсчёта
	pxor	%xmm0, %xmm0
	
	leaq	.write_time(%rip), %rdi
	subq	%rbx, %rax
	cvtsi2sd %rax, %xmm0
	movq	$1, %rax
	divsd	.CLOCKS_PER_SEC(%rip), %xmm0
	call	printf@PLT		# выводим время
	
	jmp	.common_end	
	
	.else:
	leaq	.bad_input(%rip), %rdi
	call	printf@PLT

	.common_end:
	addq	$24, %rsp
	popq	%rbx
	popq	%r13
	popq	%r12
	movq	%rbp, %rsp
	popq	%rbp
        ret
        .size   main, .-main
