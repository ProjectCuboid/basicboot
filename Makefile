ASM     = nasm
CC      = i686-linux-musl-gcc
LD      = i686-linux-musl-ld

ASMFLAGS = -f bin
CFLAGS   = -m32 -ffreestanding -nostdlib -fno-pie -fno-pic -static -O2 -Wall -Wextra -fno-stack-protector
LDFLAGS  = -m elf_i386 -Ttext 0x1000 --oformat binary -e kernel_main -nostdlib

BOOT_SRC = boot.asm
KERNEL_SRC = kernel.c
KERNEL_OBJ = kernel.o

BOOT_BIN = boot.bin
KERNEL_BIN = kernel.bin
OS_IMAGE = os.img

.PHONY: all clean run

all: $(OS_IMAGE)

$(BOOT_BIN): $(BOOT_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

$(KERNEL_OBJ): $(KERNEL_SRC)
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_BIN): $(KERNEL_OBJ)
	$(LD) $(LDFLAGS) $< -o $@

$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $^ > $@

run: $(OS_IMAGE)
	qemu-system-i386 -fda $<

clean:
	rm -f $(BOOT_BIN) $(KERNEL_BIN) $(KERNEL_OBJ) $(OS_IMAGE)