#!/bin/sh

set -e

CROSS=cross/gcc-rv64imac.ini
OPT=2

# Delete old build files.
rm -rf build

# Setup QEMU version
PLATFORM=qemu_virt
meson setup build/qemu/hello hello --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM
meson setup build/qemu/ipc ipc --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM

# Setup Cheshire version
PLATFORM=cheshire
meson setup build/cheshire/hello hello --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM
meson setup build/cheshire/ipc ipc --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM -Dtemporal_fence=false
meson setup build/cheshire/ipc-cold ipc --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM -Dtemporal_fence=true
meson setup build/cheshire/ipc-load ipc --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM -Dcounter='load'
meson setup build/cheshire/ipc-store ipc --optimization=$OPT --buildtype=release --cross-file=$CROSS -Dplat=$PLATFORM -Dcounter='store'
