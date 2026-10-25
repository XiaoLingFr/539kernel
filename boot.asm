start:
    mov ax, 0x07C0
    mov ds, ax

    mov si, title_string
    call print_string

    mov si, message_string
    call print_string

    call load_kernel_from_disk
    jmp 0900h:0000

load_kernel_from_disk:
    mov ax, 0x0900
    mov es, ax

    mov ah, 0x02
    mov al, 0x01
    xor ch, ch
    mov cl, 0x02
    xor dh, dh
    mov dl, 0x80

    xor bx, bx
    int 0x13

    jc  kernel_load_error

    ret

kernel_load_error:
    mov si, load_error_string
    call print_string

    jmp $

print_string:
    mov ah, 0x0E

print_char:
    lodsb
    cmp al, 0
    je print_finished
    int 0x10
    jmp print_char

print_finished:
    mov al, 0x0A;
    int 0x10

    mov ah, 0x03
    xor bh, bh
    int 0x10

    mov ah, 0x02
    xor dl, dl
    int 0x10
    ret

title_string:
    db "The bootloader of the 539 Kernel",0

message_string:
    db "The kernel is loading",0

load_error_string:
    db "Kernel could not be loaded",0

times 510-($-$$) db 0
dw 0xAA55