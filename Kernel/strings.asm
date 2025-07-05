bits 32

starting_ArOS_str db "Starting ArOS...", 10, 0
init_pit_str db "[PIT] Initialized PIT", 10, 0

system_timer_str db "System timer fired! ", 10, 0

print_regs_str1 db "EAX = ", 10, 0
print_regs_str2 db "EBX = ", 10, 0
print_regs_str3 db "ECX = ", 10, 0
print_regs_str4 db "EDX = ", 10, 0
print_regs_str5 db "CR0 = ", 10, 0

version_str db "0.0.1", 0
command_processor db "CMDPRC    X", 0
HEXTABLE db "0123456789ABCDEF", 0