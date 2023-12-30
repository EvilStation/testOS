section .text
	
    bits 32
    extern main

	call	ClrScr32
    call main
    jmp $
	%include "stdio.inc"