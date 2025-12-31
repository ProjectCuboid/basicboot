void kernel_main(void) {
    volatile unsigned char* vga = (volatile unsigned char*)0xA0000;
    
    for (int i = 0; i < 64000; i++) {
        vga[i] = 2;  // Green
    }
    
    for (int y = 0; y < 200; y++) {
        unsigned char color = (y / 10) & 0xFF;
        for (int x = 0; x < 320; x++) {
            vga[y * 320 + x] = color;
        }
    }
    
    while(1) {}
}