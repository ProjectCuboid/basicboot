OUTPUT_FORMAT("elf32-i386")
ENTRY(kernel_main)

SECTIONS
{
    . = 0x1000;
    
    .text : {
        kernel.o(.text)    /* Ensure kernel.o comes first so kernel_main is at 0x1000 */
        *(.text)           /* All other .text sections follow */
    }
    
    .data : {
        *(.data)
    }
    
    .bss : {
        *(.bss)
    }
}