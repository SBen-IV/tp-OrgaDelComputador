// size_t writeall(int fd, const void *buf, size_t count);
.globl writeall
writeall:
	push %r12
	push %r13
	push %r14
	push %r15
	movq %rdi, %r12 // fd
	movq %rsi, %r13 // buf
	movq %rdx, %r14 // count (leidos)
	xor %rax, %rax
	xor %r15, %r15 // total_bytes_escritos

.write_loop:
	movq %r12, %rdi
	leaq (%r13, %r15, 1), %rsi
	movq %r14, %rdx
	call write

	cmp $-1, %rax
	je .return

	addq %rax, %r15 // total_bytes_escritos + escritos
	subq %rax, %r14 // leidos - escritos
	jg .write_loop // r14 > rax
	xorq %r15, %r15

.return:
	movq %r15, %rax
	pop %r15
	pop %r14
	pop %r13
	pop %r12

    ret