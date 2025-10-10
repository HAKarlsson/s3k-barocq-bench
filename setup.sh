#!/bin/bash

CROSS=cross/gcc-rv64imac.ini
OPT=2

case "$1" in
 "cheshire") 
 	PLATFORM="cheshire"
	;;
 "qemu") 
 	PLATFORM="qemu_virt"
	;;
 *)
	echo "Invalid platform"
	exit 1
	;;
esac

# Delete old build files.
rm -rf build

# Setup C S3K
meson setup build/s3k-c s3k-c/kernel --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM
ninja -C build/s3k-c s3k-c.elf

# Setup Barocq S3K
meson setup build/s3k-barocq s3k-barocq/kernel --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM
ninja -C build/s3k-barocq s3k.elf

# Setup hello world example
meson setup build/hello hello --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM
ninja -C build/hello

meson setup build/ipc ipc --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM
ninja -C build/ipc
