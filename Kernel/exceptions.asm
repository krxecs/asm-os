; exceptions.asm

init_exceptions:
	pushad
	mov cx, CODE_DESC
	xor ebx, ebx

	.register:
		mov eax, exc_handler00
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler01
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler02
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler03
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler04
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler05
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler06
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler07
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler08
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler09
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler10
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler11
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler12
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler13
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler14
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler15
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler16
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler17
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler18
		call install_isr_ring0

		inc ebx
		mov eax, exc_handler19
		call install_isr_ring0

	.end:
		popad
		ret

exc_handler00:
	push esi
	mov esi, exc_string00
	call print32
	pop esi
	iretd

exc_handler01:
	push esi
	mov esi, exc_string01
	call print32
	pop esi
	iretd

exc_handler02:
	push esi
	mov esi, exc_string02
	call print32
	pop esi
	iretd

exc_handler03:
	push esi
	mov esi, exc_string03
	call print32
	pop esi
	iretd

exc_handler04:
	push esi
	mov esi, exc_string04
	call print32
	pop esi
	iretd

exc_handler05:
	push esi
	mov esi, exc_string05
	call print32
	pop esi
	iretd

exc_handler06:
	push esi
	mov esi, exc_string06
	call print32
	pop esi
	iretd

exc_handler07:
	push esi
	mov esi, exc_string07
	call print32
	pop esi
	iretd

exc_handler08:
	push esi
	mov esi, exc_string08
	call print32
	pop esi
	iretd

exc_handler09:
	push esi
	mov esi, exc_string09
	call print32
	pop esi
	iretd

exc_handler10:
	push esi
	mov esi, exc_string10
	call print32
	pop esi
	iretd

exc_handler11:
	push esi
	mov esi, exc_string11
	call print32
	pop esi
	iretd

exc_handler12:
	push esi
	mov esi, exc_string12
	call print32
	pop esi
	iretd

exc_handler13:
	push esi
	mov esi, exc_string13
	call print32
	pop esi
	iretd

exc_handler14:
	push esi
	mov esi, exc_string14
	call print32
	pop esi
	iretd

exc_handler15:
	push esi
	mov esi, exc_string15
	call print32
	pop esi
	iretd

exc_handler16:
	push esi
	mov esi, exc_string16
	call print32
	pop esi
	iretd

exc_handler17:
	push esi
	mov esi, exc_string17
	call print32
	pop esi
	iretd

exc_handler18:
	push esi
	mov esi, exc_string18
	call print32
	pop esi
	iretd

exc_handler19:
	push esi
	mov esi, exc_string19
	call print32
	pop esi
	iretd


	
; exc_string db 'Unknown Fatal Exception!', 10, 0
; exc_string00 db '00 - Divide Error (#DE)        ', 10, 0
; exc_string01 db '01 - Debug (#DB)               ', 10, 0
; exc_string02 db '02 - NMI Interrupt             ', 10, 0
; exc_string03 db '03 - Breakpoint (#BP)          ', 10, 0
; exc_string04 db '04 - Overflow (#OF)            ', 10, 0
; exc_string05 db '05 - BOUND Range Exceeded (#BR)', 10, 0
; exc_string06 db '06 - Invalid Opcode (#UD)      ', 10, 0
; exc_string07 db '07 - Device Not Available (#NM)', 10, 0
; exc_string08 db '08 - Double Fault (#DF)        ', 10, 0
; exc_string09 db '09 - Coprocessor Segment Over  ', 10, 0	; No longer generated on new CPU's
; exc_string10 db '10 - Invalid TSS (#TS)         ', 10, 0
; exc_string11 db '11 - Segment Not Present (#NP) ', 10, 0
; exc_string12 db '12 - Stack Fault (#SS)         ', 10, 0
; exc_string13 db '13 - General Protection (#GP)  ', 10, 0
; exc_string14 db '14 - Page-Fault (#PF)          ', 10, 0
; exc_string15 db '15 - Undefined                 ', 10, 0
; exc_string16 db '16 - x87 FPU Error (#MF)       ', 10, 0
; exc_string17 db '17 - Alignment Check (#AC)     ', 10, 0
; exc_string18 db '18 - Machine-Check (#MC)       ', 10, 0
; exc_string19 db '19 - SIMD Floating-Point (#XM) ', 10, 0

exc_string db 'Unknown Fatal Exception!', 10, 0
exc_string00 db '00 (#DE)', 10, 0
exc_string01 db '01 (#DB)', 10, 0
exc_string02 db '02 (NMI)', 10, 0
exc_string03 db '03 (#BP)', 10, 0
exc_string04 db '04 (#OF)', 10, 0
exc_string05 db '05 (#BR)', 10, 0
exc_string06 db '06 (#UD)', 10, 0
exc_string07 db '07 (#NM)', 10, 0
exc_string08 db '08 (#DF)', 10, 0
exc_string09 db '09 (#CS)', 10, 0	; No longer generated on new CPU's
exc_string10 db '10 (#TS)', 10, 0
exc_string11 db '11 (#NP)', 10, 0
exc_string12 db '12 (#SS)', 10, 0
exc_string13 db '13 (#GP)', 10, 0
exc_string14 db '14 (#PF)', 10, 0
exc_string15 db '15 (#UD)', 10, 0
exc_string16 db '16 (#MF)', 10, 0
exc_string17 db '17 (#AC)', 10, 0
exc_string18 db '18 (#MC)', 10, 0
exc_string19 db '19 (#XM)', 10, 0