	.section .rodata
	.LC6:
        	.string "%.10lf\n"
        	.text
        	.globl  main
        	.type   main, @function
main:
        pushq   %rbp
        movq    %rsp, %rbp

        movl    $0, %eax
        call    bisection_solution

        leaq    .LC6(%rip), %rdi
        movl    $1, %eax
        call    printf@PLT

        movl    $0, %eax
        popq    %rbp
        ret
        .size   main, .-main
