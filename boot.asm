[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; ---- get VESA mode info (0x111)
    mov ax, 0x4F01
    mov cx, 0x0111
    mov di, vesa_info
    int 0x10
    cmp ax, 0x004F
    jne disk_error

    ; ---- set VESA 640x480x16bpp + LFB
    mov ax, 0x4F02
    mov bx, 0x4111
    int 0x10
    cmp ax, 0x004F
    jne disk_error

    ; ---- pass framebuffer info to kernel
    mov eax, [vesa_info + 0x28] ; LFB address
    mov [0x9000], eax

    mov ax, [vesa_info + 0x10]  ; pitch
    mov [0x9004], ax

    mov ax, [vesa_info + 0x12]  ; width
    mov [0x9006], ax

    mov ax, [vesa_info + 0x14]  ; height
    mov [0x9008], ax

    ; ---- load kernel
    mov ax, 0
    mov es, ax
    mov bx, 0x1000
    mov ah, 0x02
    mov al, 9
    mov ch, 0
    mov cl, 2
    mov dh, 0
    int 0x13
    jc disk_error

    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:protected_mode

disk_error:
    hlt

vesa_info:
    times 256 db 0


[BITS 32]
protected_mode:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000
    
    call 0x1000    ; +++++++ CALL KERNEL ENTRY POINT
                   ;   l++++ RETURN HERE IF KERNEL RETURNS [ THIS SHOULD NOT HAPPEN ]
    hlt            ; ++l

gdt_start:
    dq 0
gdt_code:
    dw 0xFFFF
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0
gdt_data:
    dw 0xFFFF
    dw 0
    db 0
    db 10010010b
    db 11001111b
    db 0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

times 510-($-$$) db 0
dw 0xAA55