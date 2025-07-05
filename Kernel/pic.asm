; Command port :: PIC1: 0x20
;                 PIC2: 0xA0
; Data port:: PIC1: 0x21
;             PIC2: 0xA1

irq_mask db 0xFF

%define pic1_port_cmd 0x20
%define pic1_port_data 0x21

%define pic2_port_cmd 0xA0
%define pic2_port_data 0xA1

%define pic1_offsetAddr 0x20
%define pic2_offsetAddr 0x28

init_pics:
    push ax

    mov al, 0x11
    out pic1_port_cmd, al     ;restart PIC1
    out pic2_port_cmd, al     ;restart PIC2

    mov al, pic1_offsetAddr
    out pic1_port_data, al     ;PIC1 now starts at 32
    mov al, pic2_offsetAddr
    out pic2_port_data, al     ;PIC2 now starts at 40

    mov al, 0x04
    out pic1_port_data, al     ;setup cascading
    mov al, 0x02
    out pic2_port_data, al

    mov al, 0x01
    out pic1_port_data, al
    out pic2_port_data, al     ;done!

    mov al, 0xFF
    out pic1_port_data, al
    out pic2_port_data, al

    pop ax
    ret