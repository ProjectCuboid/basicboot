ASM     = nasm
CC      = i686-linux-musl-gcc
LD      = i686-linux-musl-ld
OBJCOPY = i686-linux-musl-objcopy

ASMFLAGS = -f bin
CFLAGS   = -m32 -ffreestanding -nostdlib -fno-pie -fno-pic -static -O2 -Wall -Wextra -fno-stack-protector
LDFLAGS  = -m elf_i386 -T linker.ld -nostdlib

BOOT_SRC = boot.asm

KERNEL_SRCS = kernel.c cubios-essentials.c # +++++++++ KERNEL.C MUST BE FIRST

KERNEL_OBJS = $(KERNEL_SRCS:.c=.o)

KERNEL_ELF = kernel.elf
BOOT_BIN = boot.bin
KERNEL_BIN = kernel.bin
OS_IMAGE = os.img

.PHONY: all clean run debug

all: $(OS_IMAGE)

$(BOOT_BIN): $(BOOT_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_ELF): $(KERNEL_OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@

$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $^ > $@
	truncate -s 5120 $@

run: $(OS_IMAGE)
	qemu-system-i386 -drive format=raw,file=$<

debug: $(OS_IMAGE)
	qemu-system-i386 -drive format=raw,file=$< -monitor stdio

clean:
	rm -f $(BOOT_BIN) $(KERNEL_BIN) $(KERNEL_OBJS) $(KERNEL_ELF) $(OS_IMAGE)