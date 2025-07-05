; interrupts.asm

; IDT Structure
align 8
idt_data resq 256
idt_end:
; END of IDT Structure

align 8
idt_desc:  
    .limit dw idt_end - idt_data - 1    ; limit (Size of IDT)
    .base dd idt_data           ; base of IDT

;struc idt_entry_struct
;    base_low:  resb 2 --> ; base + 0
;    sel:       resb 2 --> ; base + 0 + 2
;    always0:   resb 1 --> ; base + 0 + 2 + 2
;    flags:     resb 1 --> ; base + 0 + 2 + 2 + 1
;    base_high: resb 2 --> ; base + 0 + 2 + 2 + 1 + 1
;endstruc

;IN:: CX:EAX = segment : memory location in segment
;     EBX = 'x'th interrupt to put
;     DL = Attribute
;OUT:: Nothing
install_isr:
    push ebx
    mov ebx, [esp]
    shl ebx, 3  ; quick multiply by 8
    add ebx, idt_data

    mov word [ebx], ax
    mov word [ebx + 2], cx
    mov byte [ebx + 2 + 2], 0
    mov byte [ebx + 2 + 2 + 1], dl
    push edx
    mov edx, eax
    and edx, 0xffff0000
    shr edx, 16
    mov word [ebx + 2 + 2 + 1 + 1], dx
    pop edx

    pop ebx
    ret

;IN:: CX:EAX = segment : memory location in segment
;     EBX = 'x'th interrupt to put
;OUT:: Nothing
install_isr_ring0:
    push edx
    mov dl, 0x8e
    call install_isr
    pop edx
    ret


    