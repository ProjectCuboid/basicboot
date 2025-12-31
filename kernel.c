#include "cubios-essentials.h"

void kernel_main(void) {
    clear_screen(0);
    
    for (int y = 0; y < VGA_HEIGHT; y++) {
        for (int x = 0; x < VGA_WIDTH; x++) {
            unsigned char color = ((x + y) / 2) & 0xFF;
            draw_pixel(x, y, color);
        }
    }
    
    while(1) {}
}