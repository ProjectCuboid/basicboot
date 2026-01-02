#include "cubios-essentials.h"

uint16_t* framebuffer;
uint16_t screen_width;
uint16_t screen_height;
uint16_t screen_pitch;

static inline uint16_t rgb565(uint8_t r, uint8_t g, uint8_t b) {
    return ((r >> 3) << 11) |
           ((g >> 2) << 5)  |
           (b >> 3);
}

void draw_pixel(int x, int y, uint8_t r, uint8_t g, uint8_t b) {
    if (x < 0 || y < 0 || x >= screen_width || y >= screen_height)
        return;

    uint32_t index = y * (screen_pitch / 2) + x;
    framebuffer[index] = rgb565(r, g, b);
}

void clear_screen(uint8_t r, uint8_t g, uint8_t b) {
    uint16_t color = rgb565(r, g, b);
    for (int y = 0; y < screen_height; y++)
        for (int x = 0; x < screen_width; x++)
            framebuffer[y * (screen_pitch / 2) + x] = color;
}
