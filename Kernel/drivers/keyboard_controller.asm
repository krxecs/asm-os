;keyboard.asm

; keyboard controller ports
%define KYBRD_CTRL_STATS_REG 0x64
%define KYBRD_CTRL_CMD_REG 0x64

; keyboard encoder ports
%define KYBRD_ENC_INPUT_BUF 0x60
%define KYBRD_ENC_CMD_REG 0x60

; keyboard controller status mask
%define KYBRD_CTRL_STATS_MASK_OUT_BUF_FULL 1		; 00000001
%define KYBRD_CTRL_STATS_MASK_IN_BUF_FULL 2		; 00000010
%define KYBRD_CTRL_STATS_MASK_SYSTEM 4		; 00000100
%define KYBRD_CTRL_STATS_MASK_CMD_DATA 8		; 00001000
%define KYBRD_CTRL_STATS_MASK_LOCKED 0x10		; 00010000
%define KYBRD_CTRL_STATS_MASK_AUX_BUF 0x20		; 00100000
%define KYBRD_CTRL_STATS_MASK_TIMEOUT 0x40		; 01000000
%define KYBRD_CTRL_STATS_MASK_PARITY 0x80		; 10000000

; keyboard controller commands
%define KYBRD_CTRL_CMD_READ 0x20,
%define KYBRD_CTRL_CMD_WRITE 0x60,
%define KYBRD_CTRL_CMD_SELF_TEST 0xAA,
%define KYBRD_CTRL_CMD_INTERFACE_TEST 0xAB,
%define KYBRD_CTRL_CMD_DISABLE 0xAD,
%define KYBRD_CTRL_CMD_ENABLE 0xAE,
%define KYBRD_CTRL_CMD_READ_IN_PORT 0xC0,
%define KYBRD_CTRL_CMD_READ_OUT_PORT 0xD0,
%define KYBRD_CTRL_CMD_WRITE_OUT_PORT 0xD1,
%define KYBRD_CTRL_CMD_READ_TEST_INPUTS 0xE0,
%define KYBRD_CTRL_CMD_SYSTEM_RESET 0xFE,
%define KYBRD_CTRL_CMD_MOUSE_DISABLE 0xA7,
%define KYBRD_CTRL_CMD_MOUSE_ENABLE 0xA8,
%define KYBRD_CTRL_CMD_MOUSE_PORT_TEST 0xA9,
%define KYBRD_CTRL_CMD_MOUSE_WRITE 0xD4

; keyboard encoder commands
%define KYBRD_ENC_CMD_SET_LED 0xED,
%define KYBRD_ENC_CMD_ECHO 0xEE,
%define KYBRD_ENC_CMD_SCAN_CODE_SET 0xF0,
%define KYBRD_ENC_CMD_ID 0xF2,
%define KYBRD_ENC_CMD_AUTODELAY 0xF3,
%define KYBRD_ENC_CMD_ENABLE 0xF4,
%define KYBRD_ENC_CMD_RESETWAIT 0xF5,
%define KYBRD_ENC_CMD_RESETSCAN 0xF6,
%define KYBRD_ENC_CMD_ALL_AUTO 0xF7,
%define KYBRD_ENC_CMD_ALL_MAKEBREAK 0xF8,
%define KYBRD_ENC_CMD_ALL_MAKEONLY 0xF9,
%define KYBRD_ENC_CMD_ALL_MAKEBREAK_AUTO 0xFA,
%define KYBRD_ENC_CMD_SINGLE_AUTOREPEAT 0xFB,
%define KYBRD_ENC_CMD_SINGLE_MAKEBREAK 0xFC,
%define KYBRD_ENC_CMD_SINGLE_BREAKONLY 0xFD,
%define KYBRD_ENC_CMD_RESEND 0xFE,
%define KYBRD_ENC_CMD_RESET 0xFF

; current scan code
_scancode db 0

; lock keys
; bit 0 = NumLock
; bit 1 = ScrollLock
; bit 2 = CapsLock
_locks db 0
%define MASK_KYBRD_NUMLOCK_APPLIED 1 << 0
%define MASK_KYBRD_SCROLL_LOCK_APPLIED 1 << 1
%define MASK_KYBRD_CAPSLOCK_APPLIED 1 << 2

; shift, alt, and ctrl keys current state
; bit 0 = '0' if 'Shift' released, '1' if 'Shift' still pressed
; bit 1 = '0' if 'Alt' released, '1' if 'Alt' still pressed
; bit 2 = '0' if 'Ctrl' released, '1' if 'Ctrl' still pressed
_special_keys_pressed db 0
%define MASK_KYBRD_SHIFT_PRESSED 1 << 0
%define MASK_KYBRD_ALT_PRESSED 1 << 1
%define MASK_KYBRD_CTRL_PRESSED 1 << 2

; set if keyboard error
_kkybrd_error db 0;

; bit 0 = '0' if BAT test passed, '1' if BAT test failed
; bit 1 = '0' if diagnostics passed, '1' if diagnostics failed
; bit 2 = '0' if system should NOT resend last command, '1' if system should resend last command
; bit 3 = '0' if keyboard is enabled, '1' if keyboard is disabled
additional_bools db 0
%define MASK_KYBRD_BAT_PASSED 1 << 0
%define MASK_KYBRD_DIAGNOSTICS_PASSED 1 << 1
%define MASK_KYBRD_RESEND_CMD 1 << 2
%define MASK_KYBRD_ENABLED 1 << 3

;In:: AL = Command to send
;OUT:: Nothing
kybrd_ctrl_send_cmd:
	call wait_kybrd_write
	out KYBRD_CTRL_CMD_REG, al
	ret

;In:: Nothing
;OUT:: Nothing
disable_kybrd:
	push ax
	mov al, [additional_bools]
	test al, MASK_KYBRD_ENABLED
	jnz .main
	jmp .end

	.main
		mov al, KYBRD_CTRL_CMD_DISABLE
		out KYBRD_CTRL_CMD_REG, al
		or byte [additional_bools], MASK_KYBRD_ENABLED

	.end:
		pop ax
		ret

;In:: Nothing
;OUT:: Nothing
enable_kybrd:
	push ax
	mov al, [additional_bools]
	test al, MASK_KYBRD_ENABLED
	jz .main
	jmp .end

	.main:
		mov al, KYBRD_CTRL_CMD_DISABLE
		out KYBRD_CTRL_CMD_REG, al
		mov al, [additional_bools]
		and al, 11110111b
		mov [additional_bools], al

	.end
		pop ax
		ret

;In:: Nothing
;OUT:: Nothing
wait_kybrd_write:
	push ax

	.wait:
		in al, KYBRD_CTRL_STATS_REG
		test al, KYBRD_CTRL_STATS_MASK_IN_BUF_FULL
		jnz .wait

	pop ax
	ret

;In:: Nothing
;OUT:: Nothing
wait_kybrd_read:
	push ax

	.wait:
		in al, KYBRD_CTRL_STATS_REG
		test al, KYBRD_CTRL_STATS_MASK_OUT_BUF_FULL
		jnz .wait

	pop ax
	ret

get_scancode: