FROM debian:bookworm-slim as builder

RUN apt-get -y update && \
    apt-get -y install build-essential automake autoconf autoconf-archive libtool libboost-program-options-dev libgtkmm-2.4-dev gerbv git librsvg2-dev libgeos++-dev

RUN git clone https://github.com/pcb2gcode/pcb2gcode.git /pcb2gcode

WORKDIR /pcb2gcode/

RUN git reset --hard 07c6df4cad2712e3cac7143f04e7a97a71f970b2

# Fix: Debian is shipping gerbv with wrong pkgconfig
# See https://github.com/pcb2gcode/pcb2gcode/issues/626
RUN sed -i '/Version: /c\Version: 2.10.0' /usr/lib/x86_64-linux-gnu/pkgconfig/libgerbv.pc

RUN autoreconf -fvi && \
    ./configure && \
    make && \
    make install

FROM debian:bookworm-slim as runner

RUN apt-get update && \
    apt-get install -y --no-install-recommends libboost-program-options-dev gerbv libgeos++-dev && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/pcb2gcode /usr/local/bin/pcb2gcode

WORKDIR /data/

ENTRYPOINT ["/usr/local/bin/pcb2gcode"]