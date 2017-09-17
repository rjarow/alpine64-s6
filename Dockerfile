FROM scratch
LABEL maintainer "rjarow <github.com/rjarow>" architecture="AMD64/x86_64"  alpineversion="3.6.2"

ADD alpine-minirootfs-3.6.2-x86_64.tar.gz /
CMD ["/bin/sh"]
