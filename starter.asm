[bits 16]
extern kernel_main
start:
    mov ax, cs 
    mov ds, ax
    
    call load_gdt
    call init_video_mode
    call enter_protected_mode
    call setup_interrupts

    jmp start_kernel

setup_interrupts:
    call remap_pic
    call load_idt

    ret

load_gdt:
    cli
    lgdt [gdt_ptr - start]

    jmp 0x08:load_gdt_continue

load_gdt_continue:
    mov ax, 10h
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ret

enter_protected_mode:
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    ret

init_video_mode:
    mov ax, 0x0003
    int 10h

    ret

[bits 32]
start_kernel:
    call kernel_main

%include "gdt.asm"
%include "idt.asm"