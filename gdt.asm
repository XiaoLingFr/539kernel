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

gdtr:
gdt_size_in_bytes:
    dw (5*8)
gdt_base_address:
    dd gdt