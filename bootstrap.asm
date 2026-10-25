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
    mov ax, [curr_sector_to_load]
    sub ax, 2
    mov bx, 512d
    mul bx
    mov bx, ax
    
    mov ax, 0900h
    mov es, ax
    
    mov ah, 02h
    mov al, 1h
    mov ch, 0h
    mov cl, [curr_sector_to_load]
    mov dh, 0h
    mov dl, 80h
    int 13h
        
    jc kernel_load_error
    
    sub byte [number_of_sectors_to_load], 1
    add byte [curr_sector_to_load], 1
    cmp byte [number_of_sectors_to_load], 0
    
    jne load_kernel_from_disk
    
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

number_of_sectors_to_load:
    db  15d
curr_sector_to_load:
    db  2d

times 510-($-$$) db 0
dw 0xAA55