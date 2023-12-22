.PHONY: all

BUILD_DIR = ../build
SRC = STAGE1.asm
TRGT = STAGE1.bin

all: $(TRGT)

$(TRGT): $(SRC) | $(BUILD_DIR)
	nasm -f bin $< -o $(BUILD_DIR)/$@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)