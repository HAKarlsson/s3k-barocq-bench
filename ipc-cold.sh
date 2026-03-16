#!/bin/bash

set -e

case "$1" in
 barocq|c)
	ninja -C build/s3k-$1 s3k.elf s3k.da
	export KERNEL=build/s3k-$1/s3k.elf
	;;
 *)
	echo "You have not selected a kernel"
	exit 1
esac

ninja -C build/ipc-cold
export APPS="build/ipc-cold/subprojects/app0/app0.elf build/ipc-cold/subprojects/app1/app1.elf"

case "$2" in
 qemu) 
 	./scripts/qemu.sh
	;;
 cheshire) 
 	./scripts/cheshire.sh
	;;
 *)
	echo "You have not selected target platform."
esac
