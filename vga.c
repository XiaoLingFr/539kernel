#include "vga.h"
volatile unsigned char *video = (volatile unsigned char *)0xB8000;
int nextTextPos = 0;
int currLine = 0;

int puts(char *str){
    int currCharLocationInVidMem, currColorLocationInVidMem;
    int counter = -1;

    if(str == ((void *)0)){
        goto conclusion;
    }

    counter++;

    while (*str != '\0' )
    {
        currCharLocationInVidMem = nextTextPos * 2;
        currColorLocationInVidMem = currCharLocationInVidMem + 1;
        
        video[currCharLocationInVidMem] = *str;
        video[currColorLocationInVidMem] = 15;
        
        nextTextPos++;
        str++;
        counter = counter + 1;
    }

    nextTextPos = ++currLine * 80;

    conclusion:
    return counter;
}

void putchar(char c){
    int currCharLocationInVidMem = nextTextPos * 2;
    int currColorLocationInVidMem = currCharLocationInVidMem + 1;
    
    video[currCharLocationInVidMem] = c;
    video[currColorLocationInVidMem] = 15;
    
    nextTextPos++;

    return;
}

void puti(int num){
    if(num >= 0 && num <= 9){
        putchar('0'+num);
    }
    else{
        puti(num/10);
        puti(num%10);
    }
    return;
}