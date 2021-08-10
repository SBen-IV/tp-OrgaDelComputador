// ssize_t getsize(int atdirfd, const char *filename);
.globl getsize
getsize:
	subq $144, %rsp
	movq %rsp, %rdx // stat
	movq $0, %rcx
	call fstatat

	movl 24(%rsp), %r8d
	andl $0x8000, %r8d
	jne .es_regular
	movq $-1, %rax
	jmp .return

.es_regular:
	movq 48(%rsp), %rax

.return:
	addq $144, %rsp
    ret