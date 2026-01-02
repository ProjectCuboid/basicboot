#ifndef GRAPHICS_H
#define GRAPHICS_H

#include <stdint.h>

extern uint16_t* framebuffer;
extern uint16_t screen_width;
extern uint16_t screen_height;
extern uint16_t screen_pitch;

void draw_pixel(int x, int y, uint8_t r, uint8_t g, uint8_t b);
void clear_screen(uint8_t r, uint8_t g, uint8_t b);

#endif
