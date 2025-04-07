	.file	"testprog1.c"
	.text
	.section	.rodata
.LC0:
	.string	" a[1] : %d \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$416, %rsp
	movl	$10, -416(%rbp)
	movl	$20, -412(%rbp)
	movl	$2, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	subl	$1, %eax
	cltq
	movl	-416(%rbp,%rax,4), %eax
	imull	-4(%rbp), %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	subl	$2, %eax
	cltq
	movl	-416(%rbp,%rax,4), %eax
	movl	-4(%rbp), %edx
	subl	$1, %edx
	imull	%edx, %eax
	leal	(%rcx,%rax), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	%edx, -416(%rbp,%rax,4)
	addl	$1, -4(%rbp)
.L2:
	cmpl	$99, -4(%rbp)
	jle	.L3
	movl	-412(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
