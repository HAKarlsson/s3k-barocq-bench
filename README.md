# S3K Barocq Benchmarking Suite

Clone the repository with submodules:
```bash
git clone --recursive git@github.com:HAKarlsson/s3k-barocq-bench.git
```

## Build toolchain

The toolchain required for this benchmarking suite can be built using a docker container.
The container configuration file is `toolchain/Dockerfile`.

Build as follows using *rootless* Docker (I have not tested rooted docker):
```bash
docker build -t s3k-toolchain --ssh default toolchain
```

The toolchain takes a *very* long time to build.
Once built, it will give you access to the `riscv64-unknown-elf` toolchain, the `picolibc` library for embedded C, the `barocq` compiler, and `ccomp` (rv64-linux) compiler.

If you are using VS code, use the `devcontainer` plugin to start terminals in the `s3k-toolchain` container. Otherwise, start the container with the `./container.sh` script.

## Building projects

In the container environment, setup the projects by:
```bash
./setup.sh qemu
```
to setup the qemu configuration.

This commands will create build directories in `build/`.

## Testing the kernels.

Run a simple hello world example:
```bash
./hello.sh barocq qemu
./hello.sh c qemu
```

Run the IPC benchmark:
```bash
./ipc.sh barocq qemu
./ipc.sh c qemu
```
