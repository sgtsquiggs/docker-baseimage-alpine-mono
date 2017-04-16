FROM sgtsquiggs/alpine.glibc:3.4

MAINTAINER sgtsquiggs

ENV LANG=C.UTF-8
ENV MEDIAINFO_VERSION="0.7.94"

RUN \
# install packages
    apk add --no-cache \
        sqlite-libs \
        libstdc++ &&\
    apk add --no-cache \
        --virtual=build-dependencies \
        ca-certificates \
        curl \
        g++ \
        gcc \
        git \
        make \
        tar \
        xz \
        zlib-dev &&\

# install mono
    curl -o /tmp/mono.pkg.tar.xz \
        -L https://www.archlinux.org/packages/extra/x86_64/mono/download/ &&\
    tar -xJf /tmp/mono.pkg.tar.xz &&\
    cert-sync /etc/ssl/certs/ca-certificates.crt &&\

# install libmediainfo
    curl -o \
        /tmp/mediainfo.src.tar.xz -L \
        https://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VERSION}/MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz &&\
    tar -xJf /tmp/mediainfo.src.tar.xz \
        -C /tmp &&\
    cd /tmp/MediaInfo_DLL_GNU_FromSource &&\
    ./SO_Compile.sh &&\
    cd /tmp/MediaInfo_DLL_GNU_FromSource/MediaInfoLib/Project/GNU/Library &&\
    make install &&\
    cd /tmp/MediaInfo_DLL_GNU_FromSource/ZenLib/Project/GNU/Library &&\
    make install &&\

# clean up
    apk del build-dependencies &&\
    rm -rf \
        /tmp/*
