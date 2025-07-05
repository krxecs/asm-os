; accereration.asm

; bit 00 = set if SSE supported
; bit 01 = set if SSE2 supported
accererations_available dd
%define MASK_ACCERATE_SSE 1 << 0
%define MASK_ACCERATE_SSE2 1 << 1

detect_accererations:
	

; IN: Nothing
; OUT: Carry set if SSE not supported
detect_sse:
	push eax
	push ebx
	push ecx
	push edx
	clc
	mov eax, 0x1
	cpuid
	test edx, CPUID_FEAT_EDX_SSE
	jz .noSSE
	or [accererations_available], MASK_ACCERATE_SSE 
	pop edx
	pop eax
	ret

	.noSSE:
		stc
		pop edx
		pop ecx
		pop ecx
		pop eax
		ret

detect_sse2:
	push eax
	push ebx
	push ecx
	push edx
	clc
	mov eax, 0x1
	cpuid
	test edx, CPUID_FEAT_EDX_SSE2
	jz .noSSE2
	or [accererations_available], MASK_ACCERATE_SSE2
	pop edx 
	pop ecx
	pop ebx
	pop eax
	ret

	.noSSE2:
		stc
		pop edx
		pop ecx
		pop ecx
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
save_state_sse:
	fxsave [saved_state_sse]
	ret

; IN: Nothing
; OUT: Nothing
restore_state_sse:
	fxrstor [saved_state_sse]
	ret

align 16
saved_state_sse: times 512 db 0