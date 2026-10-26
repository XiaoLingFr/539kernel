#include "vga.h"
void interrupt_handler(int interrupt_number){
    puts("Interrupt recieved.");
    puti(interrupt_number);
}