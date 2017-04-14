FROM sgtsquiggs/alpine.glibc:3.4

MAINTAINER sgtsquiggs

ENV LANG=C.UTF-8

RUN \
# install packages
    apk add --no-cache \
        --virtual=build-dependencies \
        ca-certificates \
        curl \
        tar \
        xz &&\

# install mono
    curl -o /tmp/mono.pkg.tar.xz \
        -L https://www.archlinux.org/packages/extra/x86_64/mono/download/ &&\
    tar -xJf /tmp/mono.pkg.tar.xz &&\
    cert-sync /etc/ssl/certs/ca-certificates.crt &&\

# clean up
    apk del build-dependencies &&\
    rm -f \
        /tmp/*
