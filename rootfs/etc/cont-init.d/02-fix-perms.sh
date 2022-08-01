#!/usr/bin/with-contenv sh
# shellcheck shell=sh

echo "---- Fixing perms for /app and /etc/periodic/"
chown -R ${PUID}:`getent group ${PGID} | cut -d: -f1` /app/
chown -R ${PUID}:`getent group ${PGID} | cut -d: -f1` /etc/periodic/