#!/bin/bash

if [[ "$1" == "barocq" ]]
then
	KERNEL=build/s3k-barocq/s3k.elf
	ninja -C build/s3k-barocq s3k.elf
	echo "Barocq Kernel"
elif [[ "$1" == "c" ]]
then
	KERNEL=build/s3k/s3k.elf
	ninja -C build/s3k s3k.elf
	echo "C Kernel"
else
	echo "You have not selected a kernel"
	exit 1
fi

ninja -C build/ipc
APP0=build/ipc/subprojects/app0/app0.elf
APP1=build/ipc/subprojects/app1/app1.elf

qemu-system-riscv64 \
 -machine virt \
 -bios none \
 -kernel $KERNEL \
 -nographic \
 -smp 1 \
 -icount 1 \
 -m 128M \
 -device loader,file=$APP0 \
 -device loader,file=$APP1 
