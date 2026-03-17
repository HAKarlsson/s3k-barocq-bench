# S3K Barocq Benchmarking Suite

Clone the repository with submodules:

```bash
git clone --recursive git@github.com:HAKarlsson/s3k-barocq-bench.git
```

## Toolchain Setup

This benchmarking suite requires a specialized RISC-V toolchain built within a Docker container. The container configuration is defined in `.devcontainer/Dockerfile`.

### Prerequisites

- Docker with rootless configuration (recommended)
- Git with SSH access for the Barocq repository. 

### Building the Toolchain

Build the container with the following command:

```bash
docker build -t s3k-toolchain --ssh default .devcontainer 
```

> **Build Time:** The toolchain compilation is resource-intensive and may take up to an hour to complete.

### Included Components

The built container provides the following tools:

- **RISC-V Toolchain**: `riscv64-unknown-elf` for cross-compilation
- **Embedded C Library**: `picolibc` for lightweight embedded development
- **Barocq Compiler**:
- **CompCert**: `ccomp` (rv64-linux) compiler

### Container Usage

**VS Code (Recommended)**
Use the Dev Containers extension to automatically build and launch terminals within the `s3k-toolchain` container environment.

**Command Line**
Alternatively, build and start the container using:

```bash
./container.sh
```

## Building Projects

Once inside the container environment, initialize the project build directories in `build/`:

```bash
./setup.sh
```

## Running Benchmarks

### Hello World Example

Test the basic functionality with a simple hello world program:

```bash
ninja -C build/qemu/hello run-c		# Run with C kernel
ninja -C build/qemu/hello run-barocq	# Run with Barocq kernel
```

### IPC Performance Benchmark

Execute the Inter-Process Communication benchmark:

```bash
ninja -C build/qemu/ipc run-c	# Run with C kernel
ninja -C build/qemu/ipc run-barocq	# Run with Barocq kernel
```

These commands will compile and run the benchmarks, allowing you to compare performance between the Barocq and C kernels.
