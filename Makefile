# Bootloader Makefile

ASM = nasm
ASM_FLAGS = -f bin
SRC = boot.asm
OUT = boot.bin

.PHONY: all run clean

all: $(OUT)

$(OUT): $(SRC)
	$(ASM) $(ASM_FLAGS) $(SRC) -o $(OUT)

run: $(OUT)
	qemu-system-i386 -drive format=raw,file=$(OUT)

clean:
	rm -f $(OUT)
