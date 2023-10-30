#include <stdio.h>

const int byteLead = 0x80;
const int byteMask = 0x3F;

const int byte2Lead = 0xC0;
const int byte3Lead = 0xE0;
const int byte4Lead = 0xF0;

const int byteMax = (1 << 7) - 1;
const int byte2Max = (1 << 11) - 1;
const int byte3Max = (1 << 16) - 1;

void printChar(int cp) {
    if(cp <= byteMax) {
        putchar(cp);
    } else if(cp <= byte2Max) {
        putchar(byte2Lead | cp >> 6);
        putchar(byteLead | cp & byteMask);
    } else if(cp <= byte3Max) {
        putchar(byte3Lead | cp >> 12);
        putchar(byteLead | cp >> 6 & byteMask);
        putchar(byteLead | cp & byteMask);
    } else {
        putchar(byte4Lead | cp >> 18);
        putchar(byteLead | cp >> 12 & byteMask);
        putchar(byteLead | cp >> 6 & byteMask);
        putchar(byteLead | cp & byteMask);
    }
}