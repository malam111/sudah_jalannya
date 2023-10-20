ASM=nasm
AFLAG=-f bin

QFLAG=-serial stdio #pipe:pipe/guest
EXPERIMENT=-serial mon:stdio -fw_cfg name=opt/sudah_jalannya,string="-a local /dev/ttyS0 9600 xterm-256color"
DBG=-gdb tcp::9000 -S

LINKER=ld.lld
GAME=sudah_jalannya.img

SRC=bootloader.asm main.asm print.asm
OBJ=${SRC:.asm=.o}

run: build
	chmod +x ${GAME}
	qemu-system-i386 ${GAME} \
		${QFLAG} \
		#${DBG} \
		#${EXPERIMENT} \

build: ${OBJ}
	dd if=/dev/zero of=${GAME} bs=512 count=1 seek=0
	dd if=bootloader.o of=${GAME} bs=512 count=1 seek=0
	dd if=main.o of=${GAME} conv=notrunc bs=512 count=1 seek=1

%.o:%.asm
	${ASM} ${AFLAG} $^ -o $@
	

.PHONY: clean
clean:
	rm ${OBJ}
	rm ${GAME}
