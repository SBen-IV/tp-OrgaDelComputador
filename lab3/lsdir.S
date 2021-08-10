// void lsdir(DIR *dir);
.globl lsdir
lsdir:
	push %r12
	push %r13
	push %r14

	call dirfd
	movq %rax, %r12 //int atdirfd
	movq %rdi, %r13 //DIR* dir

.loop:
	movq %r13, %rdi
	call readdir
	cmp $0, %rax
	je .return
	
	leaq 19(%rax), %r14 // d_name

	cmpb $('.'), (%r14)
	je .loop

	movq %r12, %rdi //int atdirfd
	movq %r14, %rsi
	call getsize

	movq %r14, %rsi

	cmpq $-1, %rax
	je .no_es_regular

.es_regular:
	movq $fmt_reg, %rdi
	movq %rax, %rdx
	movq $0, %rax
	call printf
	jmp .loop

.no_es_regular:
	movq $fmt_nreg, %rdi
	movq $0, %rax
	call printf
	jmp .loop

.return:
	pop %r14
	pop %r13
	pop %r12
    ret

.data
fmt_reg:
   .asciz "%s\t%zu\n"  // d_name, size
fmt_nreg:
   .asciz "%s\n"       // d_name