ASM = nasm
CC = i386-elf-gcc
BOOTSTRAP_FILE = bootstrap.asm 
INIT_KERNEL_FILES = starter.asm
KERNEL_FILES = main.c vga.c
KERNEL_FLAGS = -Wall -c -m32 -ffreestanding -fno-asynchronous-unwind-tables -fno-pie
KERNEL_OUTPUTS = vga.o main.o

build: $(BOOTSTRAP_FILE) $(KERNEL_FILE)
	$(ASM) -f bin $(BOOTSTRAP_FILE) -o bootstrap.o
	$(ASM) -f elf32 $(INIT_KERNEL_FILES) -o starter.o 
	$(CC) $(KERNEL_FLAGS) $(KERNEL_FILES)
	i386-elf-ld -melf_i386 -T linker.ld starter.o $(KERNEL_OUTPUTS) -o 539kernel.elf
	i386-elf-objcopy -O binary 539kernel.elf 539kernel.bin
	dd if=bootstrap.o of=kernel.img
	dd seek=1 conv=sync if=539kernel.bin of=kernel.img bs=512 count=5
	dd seek=6 conv=sync if=/dev/zero of=kernel.img bs=512 count=2046
	qemu-system-x86_64 -s kernel.img

clean:
	rm -rf *.o
	rm -rf *.elf
	rm -rf *.bin