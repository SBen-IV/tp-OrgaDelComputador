// size_t copyfd(int fdin, int fdout, void *buf, size_t size);
.globl copyfd
copyfd:
	push %rbx
	push %r12
	push %r13
	push %r14
	push %r15
	movq %rdi, %r12 //fdin
	movq %rsi, %r13 //fdout
	movq %rdx, %r14 //buf
	movq %rcx, %r15 //size

	xor %rbx, %rbx

.read_loop:
	movq %r12, %rdi
	movq %r14, %rsi
	movq %r15, %rdx
	call read

	cmpq $0, %rax
	je .return
	jl .zero_rax // rax < 0

	movq %r13, %rdi
	movq %r14, %rsi
	movq %rax, %rdx
	push %rax
	call writeall

	pop %r8

	cmpq $0, %rax
	jne .return_error

	addq %r8, %rbx
	jmp .read_loop

.zero_rax:
	movq $0, %rax

.return_error:
	addq %rbx, %rax

.return:
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	pop %rbx
    ret