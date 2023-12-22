.PHONY: all clean qemu qemu_dbg

BUILD_DIR = build
IMG_DIR = img
STAGE1 = $(BUILD_DIR)/STAGE1.bin
STAGE2 = $(BUILD_DIR)/KRNLDR.SYS
KRNL = $(BUILD_DIR)/KRNL.SYS
DISK_IMG = $(IMG_DIR)/floppy.img


$(DISK_IMG): stage1 stage2 kernel
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	LOOPOUTPUT=$$(sudo losetup -f) && \
	sudo losetup $${LOOPOUTPUT} $(DISK_IMG) && \
	sudo mkdosfs -F 12 $${LOOPOUTPUT} && \
	sudo mount $${LOOPOUTPUT} /mnt -t msdos -o "fat=12" && \
	sudo cp $(STAGE2) /mnt && \
	sudo cp $(KRNL) /mnt && \
	sudo umount /mnt && \
	sudo losetup -d $${LOOPOUTPUT} && \
	dd conv=notrunc if=$(STAGE1) of=$(DISK_IMG)

stage1:
	make -C Stage1

stage2:
	make -C Stage2

kernel:
	make -C Kernel

$(IMG_DIR):
	mkdir -p $(IMG_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

qemu:
	GTK_PATH= qemu-system-i386 -machine q35 -fda $(DISK_IMG)

qemu_dbg:
	GTK_PATH= qemu-system-i386 -machine q35 -fda $(DISK_IMG) -s -S

clean:
	rm -rf $(BUILD_DIR)/* $(IMG_DIR)/*
