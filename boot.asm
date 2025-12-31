[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    
    mov ax, 0x0013 ; +++++++ SET VGA MODE
    int 0x10
    

    mov ax, 0x0000 ; +++++++ LOAD KERNEL FROM DISK
    mov es, ax     ;   +++++ LOAD 9 SECTORS AT 0x1000
    mov bx, 0x1000 ;   l
    mov ah, 0x02   ;   l
    mov al, 9      ; ++l
    mov ch, 0
    mov cl, 2
    mov dh, 0
    int 0x13
    jc disk_error
    

    cli            ; +++++++ ENTER PROTECTED MODE
    lgdt [gdt_descriptor]
    
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    jmp 0x08:protected_mode

disk_error:
    mov ax, 0xA000 ;   +++++ FILL SCREEN YELLOW ON DISK ERROR
    mov es, ax     ;   l
    xor di, di     ;   l
    mov cx, 32000  ;   l
    mov al, 14     ; ++l
    rep stosb
    hlt

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