#!/usr/bin/env bash

LOAD_ARGS=()

for i in $@;
do
	LOAD_ARGS+=("-ex" "load $i")
done

riscv64-unknown-elf-gdb \
 -ex "set confirm off" \
 -ex "set pagination off" \
 -ex "target extended-remote 10.100.0.1:3333" \
 -ex "set *(int*)0x3001000 = 0x0f" \
 -ex "set *(int*)0x3001010 = 0x1" \
 "${LOAD_ARGS[@]}" \
 -ex "thread 2" \
 -ex 'set $mtvec=0x10000000' \
 -ex 'set $pc=0x10000000' \
 -ex "thread 1" \
 -ex 'set $mtvec=0x10000000' \
 -ex 'set $pc=0x10000000' \
 -ex "continue"
