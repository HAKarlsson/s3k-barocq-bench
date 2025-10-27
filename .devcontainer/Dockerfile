FROM debian:latest AS s3k-toolchain

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y autoconf automake autotools-dev curl python3 \
    python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
    bison flex texinfo gperf libtool patchutils bc zlib1g-dev \
    libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev \
    libncurses5-dev meson qemu-system-riscv64 clang-format cloc opam \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain /workdir --depth 1 --branch 2025.09.28 \
 && cd /workdir \
 && ./configure --enable-multilib --with-cmodel=medany \
 && make -j4 \
 && rm -rf /workdir

RUN git clone https://github.com/picolibc/picolibc /workdir --depth 1 --branch 1.8.10 \
 && cd /workdir \
 && meson \
    --prefix="/usr/riscv64-unknown-elf" \
    --buildtype=plain \
    -Dformat-default=minimal \
    -Dminimal-io-long-long=true \
    --cross-file "scripts/cross-riscv64-unknown-elf.txt" \
    "$(pwd)" build \
 && meson compile -C build \
 && meson install -C build \
 && rm -rf /workdir

RUN opam init --disable-sandboxing -y --auto-setup --bare \
 && opam switch create 4.14.2 \
 && eval $(opam env) \
 && opam repo add coq-released https://coq.inria.fr/opam/released \
 && opam pin -y -b add https://gitlab.inria.fr/cchavano/compcert-ce.git \
 && opam install coq=8.20.1 menhir=20240715 -y

SHELL ["/bin/bash", "-c"]
RUN echo 'eval $(opam env)' >> ~/.bashrc

RUN mkdir -p -m 0700 /root/.ssh \
 && ssh-keyscan gitlab.inria.fr >> /root/.ssh/known_hosts
RUN --mount=type=ssh \
    git clone git@gitlab.inria.fr:cchavano/barocq /workdir --depth 1 \
 && cd /workdir \
 && eval $(opam env) \
 && make \
 && make install \
 && rm -rf /workdir

RUN mkdir /workdir \
 && cd /workdir \
 && curl -o compcert.tar.gz -L https://github.com/AbsInt/CompCert/archive/refs/tags/v3.16.tar.gz \
 && tar -xf compcert.tar.gz \
 && cd CompCert-3.16 \
 && eval $(opam env) \
 && ./configure -toolprefix riscv64-unknown-elf- -prefix /opt/ccomp rv64-linux \
 && make \
 && make install \
 && rm -rf /workdir

RUN echo 'export PATH=/opt/ccomp/bin:$PATH' >> ~/.bashrc

CMD ["bash"]
