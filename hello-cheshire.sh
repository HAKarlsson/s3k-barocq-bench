#!/bin/bash

if [[ "$1" == "barocq" ]]
then
	KERNEL=build/s3k-barocq/s3k.elf
	ninja -C build/s3k-barocq s3k.elf
	echo "Barocq Kernel"
elif [[ "$1" == "c" ]]
then
	KERNEL=build/s3k-c/s3k.elf
	ninja -C build/s3k-c s3k.elf
	echo "C Kernel"
else
	echo "You have not selected a kernel"
	exit 1
fi

ninja -C build/hello
APP0=build/hello/subprojects/app0/app0.elf
APP1=build/hello/subprojects/app1/app1.elf

riscv64-unknown-elf-gdb \
-ex "set confirm off" \
-ex "set pagination off" \
-ex "target extended-remote 10.100.0.1:3333" \
-ex "set *(int*)0x3001000 = 0x0f" \
-ex "set *(int*)0x3001010 = 0x1" \
-ex "load $APP0" \
-ex "load $APP1" \
-ex "load $KERNEL" \
-ex "continue"
