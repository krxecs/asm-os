; mmngr_phys.asm

; 8 blocks per byte
%define PMMNGR_BLOCKS_PER_BYTE	8
 
; block size (4k)
%define PMMNGR_BLOCK_SIZE		4096
 
; block alignment
%define PMMNGR_BLOCK_ALIGN		PMMNGR_BLOCK_SIZE

_mmngr_memory_size dd 0

_mmngr_used_blocks dd 0

_mmngr_max_blocks dd 0

_mmngr_memory_bitmap_addr dd 0