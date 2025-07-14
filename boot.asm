[BITS 16]

start:
	mov ax, 07C0h		; Set up 4K stack space after this bootloader
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h		; Set data segment to where we're loaded
	mov ds, ax

	mov si, text_string	; Put string position into SI
	call print_string	; Call our string-printing routine

	jmp $			; Infinite loop to halt the CPU


text_string db 'Hello From Other Side!', 0  ; <-- updated string


print_string:			; Routine: output string in SI to screen
	mov ah, 0Eh		; int 10h 'print char' function

.repeat:
	lodsb			; Load next character into AL from [SI]
	cmp al, 0
	je .done		; If char is 0 (null), end of string
	int 10h			; BIOS interrupt to print AL
	jmp .repeat

.done:
	ret

times 510-($-$$) db 0	; Pad to 510 bytes
dw 0xAA55			; Boot signature
