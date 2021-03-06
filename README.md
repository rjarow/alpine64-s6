# alpine64-s6 (x86_64)

This is a base image for my other alpine based Docker Images. 

This contains the s6 overlay provided at [s6-overlay](https://github.com/just-containers/s6-overlay).

```
FROM scratch
LABEL maintainer "rjarow <github.com/rjarow>" architecture="AMD64/x86_64"  alpineversion="3.6.2"

ADD alpine-minirootfs-3.6.2-x86_64.tar.gz /

ENV S6_OVERLAY_VERSION=v1.20.1.1

RUN apk add --update --no-cache \
       bind-tools \
       ca-certificates \
       gnupg \
       net-tools \
       bash \
       curl \
       wget \
       unzip \
       nano \
       coreutils \
       shadow \
       tzdata\
       && rm -rf /var/cache/apk/*

RUN wget https://keybase.io/justcontainers/key.asc --no-check-certificate -O /tmp/s6-overlay-key.asc \
    && wget https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz --no-check-certificate -O /tmp/s6-overlay-amd64.tar.gz \
    && wget https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz.sig --no-check-certificate -O /tmp/s6-overlay-amd64.tar.gz.sig \
    && gpg --import /tmp/s6-overlay-key.asc \
    && gpg --verify /tmp/s6-overlay-amd64.tar.gz.sig /tmp/s6-overlay-amd64.tar.gz \
    && tar xvfz /tmp/s6-overlay-amd64.tar.gz -C / \
    && rm -f /tmp/s6-overlay-key.asc \
    && rm -f /tmp/s6-overlay-amd64.tar.gz \
    && rm -f /tmp/s6-overlay-amd64.tar.gz.sig

ADD rootfs /

ENTRYPOINT ["/init"]
```
