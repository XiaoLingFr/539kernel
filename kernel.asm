start:
    mov ax, cs
    mov ds, ax

    mov si, hello_string
    call print

    jmp $

print:
    mov ah, 0x0E

print_loop:
    lodsb
    cmp al, 0
    je print_end 
    int 0x10
    jmp print_loop

print_end:
    ret

hello_string:
    db "Hello from the 539 Kernel!",0