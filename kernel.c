#include "cubios-essentials.h"

void kernel_main(void) {
    framebuffer   = (uint16_t*)*(uint32_t*)0x9000;
    screen_pitch  = *(uint16_t*)0x9004;
    screen_width  = *(uint16_t*)0x9006;
    screen_height = *(uint16_t*)0x9008;

    clear_screen(0, 0, 0);

    for (int y = 0; y < screen_height; y++) {
        for (int x = 0; x < screen_width; x++) {
            draw_pixel(x, y, 255, 0, 0);
        }
    }

    for (int y = screen_height / 4; y < screen_height/4*3; y++) {
        for (int x = 0; x < screen_width; x++) {
            draw_pixel(x, y, 0, 0, 255);
        }
    }

    for (int y = 0; y < screen_height; y++) {
        for (int x = 0; x < screen_width/4; x++) {
            draw_pixel(x, y, 0, 255, 0);
        }
    }

    for (int y = 0; y < screen_height; y++) {
        for (int x = screen_width/4*3; x < screen_width; x++) {
            draw_pixel(x, y, 0, 255, 0);
        }
    }

    while (1) {}
}
