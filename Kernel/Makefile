.PHONY: all

BUILD_DIR = ../build

ASMSRC = kernel_entry.asm
CSRC = kernel.c
TRGT = KRNL.SYS
LD_FILE = linker.ld

CC = i686-elf-gcc
LD = i686-elf-ld
CFLAGS = -ffreestanding -Wall -Wextra

export PATH := $(HOME)/opt/cross/bin:$(PATH)

all: $(TRGT)

$(TRGT): $(ASMSRC) $(CSRC) | $(BUILD_DIR)
	nasm -f elf32 $(ASMSRC) -o $(BUILD_DIR)/kernel_entry.o
	$(CC) -c $(CSRC) -o $(BUILD_DIR)/kernel.o $(CFLAGS)
	$(LD) -T $(LD_FILE) -o $(BUILD_DIR)/$(TRGT) $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
