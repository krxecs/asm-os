; 0x100000000
;*******************************************************
;kernel.asm
;*******************************************************
%define NULL_DESC 0
%define CODE_DESC 0x8
%define DATA_DESC 0x10

org	0x100000			; Kernel starts at 1 MB

bits 32

kernel_start:

kernel_init:

	;-------------------------------
	;Set registers
	;-------------------------------

	mov	ax, 0x10		; set data segments to data selector (0x10)
	mov	ds, ax
	mov	ss, ax
	mov	es, ax
	mov	esp, 90000h		; stack begins from 90000h

	;---------------------------------------
	;   Clear screen and print success	
	;---------------------------------------

	call ClrScr32

	mov esi, starting_ArOS_str
	call print32
	%ifdef DEBUG
		mov esi, init_ArOS_str
		call print32
	%endif

 	call init_pics
 	%ifdef DEBUG
 		mov esi, init_pic_str
 		call print32
 	%endif

 	lidt [idt_desc]

 	call init_pics
 	
 	call init_exceptions
 	;sti
 	;call kybrd_install

 	;int 0h
 	
	jmp $
	jmp $
	;---------------------------------------;
	;   Stop execution			;
	;---------------------------------------;

	; cli
	hlt

	a_str resb 50
%include "cpuid.asm"
%include "exceptions.asm"
%include "stdio.asm"
%include "strings.asm"
%include "pic.asm"
%include "pit.asm"
%include "interrupts.asm"
%include "drivers/keyboard.asm"
%include "misc.asm"

kernel_end:
