align 8
gdt:
null_descriptor:
    dw 0
    dw 0
    dw 0
    dw 0

kernel_code_descriptor:
    dw 0xffff
    dw 0x0000
    dw 0x9a00
    dw 0x00cf

kernel_data_descriptor:
    dw 0xffff
    dw 0x0000
    dw 0x9200
    dw 0x00cf

userspace_code_descriptor:
    dw 0xffff
    dw 0x0000
    dw 0xfa00
    dw 0x00cf

userspace_data_descriptor:
    dw 0xffff
    dw 0x0000
    dw 0xf200
    dw 0x00cf
gdt_end:
align 4
gdt_ptr:
    dw gdt_end - gdt - 1
    dd gdt