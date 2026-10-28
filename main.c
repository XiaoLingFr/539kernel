#include "vga.h"
#include "idt.h"

[[noreturn]]
void kernel_main(){
    puts("Hello");
    puts("Please continue");
    
    hang:
    goto hang;
}