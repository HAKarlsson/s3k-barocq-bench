#!/usr/bin/env bash

DEVICE_ARGS=()

for i in $@
do
	DEVICE_ARGS+=("-device" "loader,file=$i")
done

qemu-system-riscv64 \
 -machine virt \
 -bios none \
 -nographic \
 -smp 1 \
 -m 128M \
 -icount 0 \
 ${DEVICE_ARGS[@]}
