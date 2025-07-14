ASM = nasm
BOOT = boot.asm
BIN = boot.bin
HD_IMG:= hd.img
HD_IMG_NAME:= "hd.img"
IMGSIZE = 16M
BUILD:=./build

all:${BUILD}/boot/boot.o
	$(shell rm -rf $(HD_IMG_NAME))
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat $(HD_IMG_NAME)
	dd if=${BUILD}/boot/boot.o of=hd.img bs=512 seek=0 count=1 conv=notrunc

${BUILD}/boot/%.o: ${BOOT}
	mkdir -p ${BUILD}/boot
	nasm $< -o $@

clean:
	$(shell rm -rf ${BUILD})

qemu:all
	qemu-system-x86_64 -hda $(HD_IMG)