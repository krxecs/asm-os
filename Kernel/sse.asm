; sse.asm

; IN: Nothing
; OUT: Carry set if SSE not supported
detect_sse:
	push eax
	clc
	mov eax, 0x1
	cpuid
	test edx, CPUID_FEAT_EDX_SSE
	jz .noSSE
	pop eax
	ret

	.noSSE:
		stc
		pop eax
		ret

detect_sse2:
	push eax
	clc
	mov eax, 0x1
	cpuid
	test edx, CPUID_FEAT_EDX_SSE2
	jz .noSSE2
	pop eax
	ret

	.noSSE2:
		stc
		pop eax
		ret

; IN: Nothing
; OUT: Nothing
enable_sse:
	push eax
	mov eax, cr0
	and ax, 0xFFFB		;clear coprocessor emulation CR0.EM
	or ax, 0x2			;set coprocessor monitoring  CR0.MP
	mov cr0, eax
	mov eax, cr4
	or ax, 3 << 9		;set CR4.OSFXSR and CR4.OSXMMEXCPT at the same time
	mov cr4, eax
	pop eax
	ret

; IN: Nothing
; OUT: Nothing
save_state:
	fxsave [saved_state_sse]
	ret

; IN: Nothing
; OUT: Nothing
restore_state:
	fxrstor [saved_state_sse]
	ret

align 16
saved_state_sse: times 512 db 0