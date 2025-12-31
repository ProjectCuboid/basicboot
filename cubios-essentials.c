#include "cubios-essentials.h"

void draw_pixel(int x, int y, unsigned char color) {
    if (x >= 0 && x < VGA_WIDTH && y >= 0 && y < VGA_HEIGHT) {
        volatile unsigned char* vga = (volatile unsigned char*)VGA_MEMORY;
        vga[y * VGA_WIDTH + x] = color;
    }
}

void clear_screen(unsigned char color) {
    volatile unsigned char* vga = (volatile unsigned char*)VGA_MEMORY;
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        vga[i] = color;
    }
}