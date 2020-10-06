FROM alpine as build

RUN apk add --no-cache --virtual gvm-build-dependencies \
    git \
    build-base \
    cmake \
    pkgconfig

RUN apk add --no-cache --virtual openvas-edge-build-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    glib-dev \
    zlib-dev \
    gnutls-dev \
    gpgme-dev \
    libuuid \
    libssh-dev \
    openldap-dev \
    hiredis-dev \
    libxml2-dev \
    libpcap-dev \
    libgcrypt-dev

ENV GVM_REVISION master
RUN git clone --depth 1 --branch ${GVM_REVISION} https://github.com/greenbone/gvm-libs.git /gvm

WORKDIR /gvm/build

RUN sed -i.bak 's/malloc_trim (0);//g' /gvm/base/hosts.c
RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/gvm \
    ..
RUN make install

