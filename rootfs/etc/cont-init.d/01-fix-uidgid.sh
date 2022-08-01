#!/usr/bin/with-contenv sh
# shellcheck shell=sh

USERNAME='alpine'

if [ -n "${PGID}" ] && [ "${PGID}" != "$(id -g ${USERNAME})" ]; then
  echo "Switching to PGID ${PGID}..."
  sed -i -e "s/^${USERNAME}:\([^:]*\):[0-9]*/${USERNAME}:\1:${PGID}/" /etc/group
  sed -i -e "s/^${USERNAME}:\([^:]*\):\([0-9]*\):[0-9]*/${USERNAME}:\1:\2:${PGID}/" /etc/passwd
fi
if [ -n "${PUID}" ] && [ "${PUID}" != "$(id -u ${USERNAME})" ]; then
  echo "Switching to PUID ${PUID}..."
  sed -i -e "s/^${USERNAME}:\([^:]*\):[0-9]*:\([0-9]*\)/${USERNAME}:\1:${PUID}:\2/" /etc/passwd
fi