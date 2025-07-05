; misc.asm

;IN:: EAX = number
;     CL = bit to set
;OUT:: EAX = result
set_bit:
	push ecx
	
	mov ecx, 1
	shl ecx, cl		; ecx = 1 << cl

	or eax, ecx		; eax = eax | ecx

	pop ecx
	ret

;IN:: EAX = number
;     CL = bit to clear
;OUT:: EAX = result
clear_bit:
	push ecx

	mov ecx, 1
	shl ecx, cl
	not ecx			; ecx = ~(1 << cl)

	and eax, ecx	; eax = eax & ecx

	pop ecx
	ret

;IN:: EAX = number
;     CL = bit to toggle
;OUT:: EAX = result
toggle_bit:
	push ecx

	mov ecx, 1
	shl ecx, cl		; ecx = 1 << cl

	xor eax, ecx	; eax = eax XOR ecx

	pop ecx
	ret

;IN:: EAX = number
;     CL = bit to check
;OUT:: EAX = either 0 or 1
check_bit:
	shr eax, cl
	and eax, 1		; eax = (eax >> cl) & 1
	ret

;IN:: EAX = number
;     CL = bit to change
;     BH = value to change the byte into (0 or 1)
;OUT:: EAX = result
change_bit:
	cmp bh, 0
	je .is0

	cmp bh, 1
	je .is1

	stc
	ret

	.is0:
		call clear_bit
		ret

	.is1:
		call set_bit
		ret