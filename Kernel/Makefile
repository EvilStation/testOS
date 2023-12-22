.PHONY: all

BUILD_DIR = ../build
SRC = Stage3.asm
TRGT = KRNL.SYS

all: $(TRGT)

$(TRGT): $(SRC) | $(BUILD_DIR)
	nasm -f bin $< -o $(BUILD_DIR)/$@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)