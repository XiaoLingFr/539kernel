#pragma once
extern volatile unsigned char *video;

extern int nextTextPos;
extern int currLine;

int puts(char *string);
void puti(int);
void putchar(char c);