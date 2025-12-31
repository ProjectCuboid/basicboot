#ifndef GRAPHICS_H
#define GRAPHICS_H

#define VGA_WIDTH 320
#define VGA_HEIGHT 200
#define VGA_MEMORY 0xA0000

void draw_pixel(int x, int y, unsigned char color);
void clear_screen(unsigned char color);

#endif