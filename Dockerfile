FROM alpine:3.16.0

ENV TZ="Europe/Paris"
ENV PUID="99"
ENV PGID="100"

RUN echo "${TZ}" > /etc/timezone
RUN apk add --no-cache busybox-initscripts openrc git curl tar xz tree nano sudo bash bash-doc bash-completion ncurses rdiff-backup
RUN rc-update add netmount boot
RUN rc-update add crond

# s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.1.2/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.1.2/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

RUN adduser --disabled-password -h /app -u ${PUID} -G `getent group ${PGID} | cut -d: -f1` -s /bin/bash alpine
RUN passwd -d alpine
RUN echo 'alpine:123456' | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
RUN adduser alpine wheel

# On change de shell pour les users actuels /etc/passwd pour bash
RUN sed -e 's;/bin/ash$;/bin/bash;g' -i /etc/passwd

# Copie des fichiers vers container
COPY rootfs /

WORKDIR /app

VOLUME [ "/app" ]

#EXPOSE 7000 8000 9000

ENTRYPOINT [ "/init" ]