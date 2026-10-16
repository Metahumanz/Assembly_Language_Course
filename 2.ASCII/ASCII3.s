	.file	"ASCII3.C"
	.intel_syntax noprefix
 # GNU C++17 (x86_64-win32-seh-rev0, Built by MinGW-Builds project) version 15.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 15.2.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.27-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -masm=intel -mtune=core2 -march=nocona -g -O0
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "C:/VScodework/Assembly_Language" "ASCII3.C"
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB118:
	.file 1 "ASCII3.C"
	.loc 1 5 1
	.cfi_startproc
	push	rbp	 #
	.seh_pushreg	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	.cfi_def_cfa_register 6
	sub	rsp, 48	 #,
	.seh_stackalloc	48
	.seh_endprologue
 # ASCII3.C:5: {
	.loc 1 5 1
	call	__main	 #
 # ASCII3.C:7:     char ch = 'a';
	.loc 1 7 10
	mov	BYTE PTR -9[rbp], 97	 # ch,
 # ASCII3.C:9:     for (i = 0; i < 2; i++)
	.loc 1 9 12
	mov	DWORD PTR -4[rbp], 0	 # i,
 # ASCII3.C:9:     for (i = 0; i < 2; i++)
	.loc 1 9 5
	jmp	.L2	 #
.L5:
 # ASCII3.C:11:         for (j = 0; j < 13; j++)
	.loc 1 11 16
	mov	DWORD PTR -8[rbp], 0	 # j,
 # ASCII3.C:11:         for (j = 0; j < 13; j++)
	.loc 1 11 9
	jmp	.L3	 #
.L4:
 # ASCII3.C:13:             putchar(ch);
	.loc 1 13 20
	movsx	eax, BYTE PTR -9[rbp]	 # _1, ch
	mov	ecx, eax	 #, _1
	call	putchar	 #
 # ASCII3.C:14:             ch++;
	.loc 1 14 15
	movzx	eax, BYTE PTR -9[rbp]	 # ch.0_2, ch
	add	eax, 1	 # _4,
	mov	BYTE PTR -9[rbp], al	 # ch, _4
 # ASCII3.C:11:         for (j = 0; j < 13; j++)
	.loc 1 11 9 discriminator 3
	add	DWORD PTR -8[rbp], 1	 # j,
.L3:
 # ASCII3.C:11:         for (j = 0; j < 13; j++)
	.loc 1 11 23 discriminator 1
	cmp	DWORD PTR -8[rbp], 12	 # j,
	jle	.L4	 #,
 # ASCII3.C:17:         putchar('\n');
	.loc 1 17 16
	mov	ecx, 10	 #,
	call	putchar	 #
 # ASCII3.C:9:     for (i = 0; i < 2; i++)
	.loc 1 9 5 discriminator 2
	add	DWORD PTR -4[rbp], 1	 # i,
.L2:
 # ASCII3.C:9:     for (i = 0; i < 2; i++)
	.loc 1 9 19 discriminator 1
	cmp	DWORD PTR -4[rbp], 1	 # i,
	jle	.L5	 #,
 # ASCII3.C:20:     return 0;
	.loc 1 20 12
	mov	eax, 0	 # _14,
 # ASCII3.C:21: }
	.loc 1 21 1
	add	rsp, 48	 #,
	pop	rbp	 #
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE118:
	.seh_endproc
.Letext0:
	.file 2 "C:/APP/mingw64/x86_64-w64-mingw32/include/stdio.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x137
	.word	0x5
	.byte	0x1
	.byte	0x8
	.secrel32	.Ldebug_abbrev0
	.uleb128 0x3
	.ascii "GNU C++17 15.2.0 -masm=intel -mtune=core2 -march=nocona -g -O0\0"
	.byte	0x21
	.byte	0x4
	.long	0x313e7
	.secrel32	.LASF0
	.secrel32	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.ascii "long int\0"
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x4
	.ascii "putchar\0"
	.byte	0x2
	.word	0x282
	.byte	0xf
	.long	0xb7
	.long	0xf5
	.uleb128 0x5
	.long	0xb7
	.byte	0
	.uleb128 0x6
	.ascii "main\0"
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.long	0xb7
	.quad	.LFB118
	.quad	.LFE118-.LFB118
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x2
	.ascii "i\0"
	.byte	0x6
	.byte	0x9
	.long	0xb7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x2
	.ascii "j\0"
	.byte	0x6
	.byte	0xc
	.long	0xb7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x2
	.ascii "ch\0"
	.byte	0x7
	.byte	0xa
	.long	0x6e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.byte	0
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x90
	.uleb128 0xb
	.uleb128 0x91
	.uleb128 0x6
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"dr"
	.long	0x2c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
	.section	.debug_line_str,"dr"
.LASF0:
	.ascii "ASCII3.C\0"
.LASF1:
	.ascii "C:\\VScodework\\Assembly_Language\0"
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-Builds project) 15.2.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
