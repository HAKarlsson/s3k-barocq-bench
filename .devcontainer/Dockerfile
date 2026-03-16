FROM docker.io/hakarlsson/riscv-picolibc AS s3k-toolchain

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y opam \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN opam init --disable-sandboxing -y --auto-setup --bare \
 && opam switch create 4.14.2 \
 && eval $(opam env) \
 && opam repo add rocq-released https://rocq-prover.org/opam/released

SHELL ["/bin/bash", "-c"]
RUN echo 'eval $(opam env)' >> ~/.bashrc

RUN mkdir -p -m 0700 /root/.ssh \
 && ssh-keyscan gitlab.inria.fr >> /root/.ssh/known_hosts
RUN --mount=type=ssh \
    git clone git@gitlab.inria.fr:cchavano/barocq --branch=v0.5 /workdir --depth 1 \
 && cd /workdir \
 && eval $(opam env) \
 && opam install . -y

#RUN mkdir /workdir \
# && cd /workdir \
# && curl -o compcert.tar.gz -L https://github.com/AbsInt/CompCert/archive/refs/tags/v3.16.tar.gz \
# && tar -xf compcert.tar.gz \
# && cd CompCert-3.16 \
# && eval $(opam env) \
# && ./configure -toolprefix riscv64-unknown-elf- -prefix /opt/ccomp rv64-linux \
# && make \
# && make install \
# && rm -rf /workdir

RUN echo 'export PATH=/opt/ccomp/bin:$PATH' >> ~/.bashrc

CMD ["bash"]
