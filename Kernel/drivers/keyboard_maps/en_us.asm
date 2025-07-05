; en_us.asm

align 16
ps2_ascii_codes:
	db 0,27
	db "1234567890-=",8
	db "	"
	db "qwertyuiop[]",10,0
	db "asdfghjkl;'`",0
	db "\zxcvbnm,./",0
	db "*",0
	db " "
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,"789"
	db "-456+"
	db "1230."
	times 128 - ($-ps2_ascii_codes) db 0

align 16
ps2_ascii_codes_caps_lock:
	db 0,27
	db "1234567890-=",8
	db "	"
	db "QWERTYUIOP[]",13,0
	db "ASDFGHJKL;'`",0
	db "\ZXCVBNM,./",0
	db "*",0
	db " "
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,"789"
	db "-456+"
	db "1230."
	times 128 - ($-ps2_ascii_codes_caps_lock) db 0

align 16
ps2_ascii_codes_shift:
	db 0,27
	db "!@#$%^&*()_+",8
	db "	"
	db "QWERTYUIOP{}",13,0
	db "ASDFGHJKL:", '"', "~",0
	db "|ZXCVBNM<>?",0
	db "*",0
	db " "
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,"789"
	db "-456+"
	db "1230."
	times 128 - ($-ps2_ascii_codes_shift) db 0

align 16
ps2_ascii_codes_shift_caps_lock:
	db 0,27
	db "!@#$%^&*()_+",8
	db "	"
	db "qwertyuiop{}",13,0
	db "asdfghjkl:", '"', "~",0
	db "|zxcvbnm<>?",0
	db "*",0
	db " "
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,"789"
	db "-456+"
	db "1230."
	times 128 - ($-ps2_ascii_codes_shift_caps_lock) db 0