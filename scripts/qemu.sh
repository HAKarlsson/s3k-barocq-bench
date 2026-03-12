#!/bin/bash

DEVICE_ARGS=()

for i in $APPS
do
	DEVICE_ARGS+=("-device" "loader,file=$i")
done

qemu-system-riscv64 \
 -machine virt \
 -bios none \
 -kernel $KERNEL \
 -nographic \
 -smp 1 \
 -m 128M \
 -icount 0 \
 ${DEVICE_ARGS[@]}
