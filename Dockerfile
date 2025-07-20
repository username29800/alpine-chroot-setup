FROM alpine:latest
WORKDIR /
RUN apk update && apk upgrade
RUN apk add git
RUN git clone https://github.com/username29800/alpine-chroot-setup
WORKDIR /alpine-chroot-setup
RUN sh setup.sh
USER user
CMD [ "zsh", "-l" ]
