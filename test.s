	.file	"test.c"
	.text
	.local	tokens
	.comm	tokens,16384,32
	.section	.rodata
.LC0:
	.string	"test"
.LC1:
	.string	"tes"
.LC2:
	.string	"tst"
.LC3:
	.string	"est"
.LC4:
	.string	"tet"
.LC5:
	.string	"testa"
.LC6:
	.string	"testb"
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
	pushq	%rbx
	.cfi_offset 3, -24
	movl	$10, tokens(%rip)
	leaq	.LC0(%rip), %rax
	movq	%rax, 8+tokens(%rip)
	movl	$10, 16+tokens(%rip)
	leaq	.LC1(%rip), %rax
	movq	%rax, 24+tokens(%rip)
	movl	$10, 32+tokens(%rip)
	leaq	.LC2(%rip), %rax
	movq	%rax, 40+tokens(%rip)
	movl	$10, 48+tokens(%rip)
	leaq	.LC3(%rip), %rax
	movq	%rax, 56+tokens(%rip)
	movl	$10, 64+tokens(%rip)
	leaq	.LC4(%rip), %rax
	movq	%rax, 72+tokens(%rip)
	movl	$10, 80+tokens(%rip)
	leaq	.LC5(%rip), %rax
	movq	%rax, 88+tokens(%rip)
	movl	$10, 96+tokens(%rip)
	leaq	.LC6(%rip), %rax
	movq	%rax, 104+tokens(%rip)
	movl	$0, %eax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 13.2.1 20230801"
	.section	.note.GNU-stack,"",@progbits
