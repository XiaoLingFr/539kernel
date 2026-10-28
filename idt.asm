extern interrupt_handler
remap_pic:
    mov al, 0x11
    
    ;send initialization command to pic master
    out 0x20, al
    ;send initialization command to pic slave
    out 0xA0, al

    ;IRQ starts from interrupt 32 in pic master
    mov al, 32d
    out 0x21, al

    ;IRQ starts from interrupt 40 in pic slave
    mov al, 40d
    out 0xA1, al

    ;send pic master the connection of pic slave
    mov al, 0x04
    out 0x21, al

    ;send pic slave the connection of pic master
    mov al, 0x02
    out 0xA1, al

    mov al, 0x01

    ;x86 to pic master
    out 0x21, al
    ;x86 to pic slave
    out 0xa1, al

    xor al, al

    ;pic master enable all irq
    out 0x21, al

    ;pic slave enable all irq
    out 0xA1, al

    ret

load_idt:
    lidt [idt_ptr - start]
    ret

%macro create_isr 1
isr_%1:
    cli
    push %1
    jmp isr_basic
%endmacro

%macro create_irq 1
isr_%1:
    cli
    push %1
    jmp irq_basic
%endmacro

create_isr 0
create_isr 1
create_isr 2
create_isr 3
create_isr 4
create_isr 5
create_isr 6
create_isr 7
create_isr 8
create_isr 9
create_isr 10
create_isr 11
create_isr 12
create_isr 13
create_isr 14
create_isr 15
create_isr 16
create_isr 17
create_isr 18
create_isr 19
create_isr 20
create_isr 21
create_isr 22
create_isr 23
create_isr 24
create_isr 25
create_isr 26
create_isr 27
create_isr 28
create_isr 29
create_isr 30
create_isr 31

create_irq 32
create_irq 33
create_irq 34
create_irq 35
create_irq 36
create_irq 37
create_irq 38
create_irq 39
create_irq 40
create_irq 41
create_irq 42
create_irq 43
create_irq 44
create_irq 45
create_irq 46
create_irq 47
create_irq 48

isr_basic:
    call interrupt_handler
    pop eax
    sti
    iret 

irq_basic:
    call interrupt_handler
    mov al, 0x20
    out 0x20, al

    cmp byte [esp], 40d
    jnge irq_basic_end

    mov al, 0xa0
    out 0x20, al

irq_basic_end:
    pop eax
    sti
    ret

idt:
    dw isr_0, 8, 0x8e00, 0x0000
    dw isr_1, 8, 0x8e00, 0x0000
    dw isr_2, 8, 0x8e00, 0x0000
    dw isr_3, 8, 0x8e00, 0x0000
    dw isr_4, 8, 0x8e00, 0x0000
    dw isr_5, 8, 0x8e00, 0x0000
    dw isr_6, 8, 0x8e00, 0x0000
    dw isr_7, 8, 0x8e00, 0x0000
    dw isr_8, 8, 0x8e00, 0x0000
    dw isr_9, 8, 0x8e00, 0x0000

    dw isr_10, 8, 0x8e00, 0x0000
    dw isr_11, 8, 0x8e00, 0x0000
    dw isr_12, 8, 0x8e00, 0x0000
    dw isr_13, 8, 0x8e00, 0x0000
    dw isr_14, 8, 0x8e00, 0x0000
    dw isr_15, 8, 0x8e00, 0x0000
    dw isr_16, 8, 0x8e00, 0x0000
    dw isr_17, 8, 0x8e00, 0x0000
    dw isr_18, 8, 0x8e00, 0x0000
    dw isr_19, 8, 0x8e00, 0x0000

    dw isr_20, 8, 0x8e00, 0x0000
    dw isr_21, 8, 0x8e00, 0x0000
    dw isr_22, 8, 0x8e00, 0x0000
    dw isr_23, 8, 0x8e00, 0x0000
    dw isr_24, 8, 0x8e00, 0x0000
    dw isr_25, 8, 0x8e00, 0x0000
    dw isr_26, 8, 0x8e00, 0x0000
    dw isr_27, 8, 0x8e00, 0x0000
    dw isr_28, 8, 0x8e00, 0x0000
    dw isr_29, 8, 0x8e00, 0x0000

    dw isr_30, 8, 0x8e00, 0x0000
    dw isr_31, 8, 0x8e00, 0x0000
    dw isr_32, 8, 0x8e00, 0x0000
    dw isr_33, 8, 0x8e00, 0x0000
    dw isr_34, 8, 0x8e00, 0x0000
    dw isr_35, 8, 0x8e00, 0x0000
    dw isr_36, 8, 0x8e00, 0x0000
    dw isr_37, 8, 0x8e00, 0x0000
    dw isr_38, 8, 0x8e00, 0x0000
    dw isr_39, 8, 0x8e00, 0x0000

    dw isr_40, 8, 0x8e00, 0x0000
    dw isr_41, 8, 0x8e00, 0x0000
    dw isr_42, 8, 0x8e00, 0x0000
    dw isr_43, 8, 0x8e00, 0x0000
    dw isr_44, 8, 0x8e00, 0x0000
    dw isr_45, 8, 0x8e00, 0x0000
    dw isr_46, 8, 0x8e00, 0x0000
    dw isr_47, 8, 0x8e00, 0x0000
    dw isr_48, 8, 0x8e00, 0x0000
idt_end:

idt_ptr:
    dw idt_end - idt - 1
    dd idt