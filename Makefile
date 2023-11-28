.PHONY: all convert clean qemu qemu_dbg
.SUFFIXES: .asm .bin .SYS

BUILD_DIR = build
IMG_DIR = img

STAGE1 = STAGE1.asm 
STAGE2 = KRNLDR.asm # Kernel Loader
STAGE1 := $(strip $(patsubst %.asm, $(BUILD_DIR)/%.bin, $(STAGE1)))
STAGE2 := $(strip $(patsubst %.asm, $(BUILD_DIR)/%.SYS, $(STAGE2)))
DISK_IMG := floppy.img

all: $(DISK_IMG)

convert: $(STAGE1) $(STAGE2)

$(BUILD_DIR)/%.bin: %.asm | $(BUILD_DIR)
	nasm -f bin $< -o $@

$(BUILD_DIR)/%.SYS: %.asm | $(BUILD_DIR)
	nasm -f bin $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(DISK_IMG): convert | $(IMG_DIR)
	dd if=/dev/zero of=$(IMG_DIR)/$(DISK_IMG) bs=512 count=2880
	sudo losetup /dev/loop0 $(IMG_DIR)/$(DISK_IMG)
	sudo mkdosfs -F 12 /dev/loop0
	sudo mount /dev/loop0 /mnt -t msdos -o "fat=12"
	sudo cp $(STAGE2) /mnt
	sudo umount /mnt
	sudo losetup -d /dev/loop0
	dd conv=notrunc if=$(STAGE1) of=$(IMG_DIR)/$(DISK_IMG)

$(IMG_DIR):
	mkdir -p $(IMG_DIR)

qemu:
	qemu-system-i386 -machine q35 -fda $(IMG_DIR)/$(DISK_IMG)

qemu_dbg:
	qemu-system-i386 -machine q35 -fda $(IMG_DIR)/$(DISK_IMG) -s -S

clean:
	rm -rf $(BUILD_DIR)/* $(IMG_DIR)/*
