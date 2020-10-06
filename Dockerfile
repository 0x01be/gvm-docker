FROM 0x01be/gvm:build as build

FROM alpine

COPY --from=build /opt/gvm/ /opt/gvm/

RUN apk add --no-cache --virtual gvm-edge-runtime-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    glib \
    zlib \
    gnutls \
    gpgme \
    libuuid \
    libssh \
    openldap \
    hiredis \
    libxml2 \
    libpcap \
    libgcrypt

