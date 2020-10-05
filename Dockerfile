FROM debian:buster AS builder

RUN apt-get update && \
    apt-get -y install build-essential clang git python flex bison pkg-config automake libtool linux-headers-amd64

COPY . /pmtud
WORKDIR /pmtud

RUN git submodule update --init --recursive && make

FROM debian:buster

COPY --from=builder /pmtud/pmtud /usr/local/sbin/pmtud

CMD /usr/local/sbin/pmtud
