#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [ ! -d "/app/ssh" ]
then
    sudo -u alpine mkdir /app/ssh
else
    # On ssh-add toutes les clefs contenus dans ce dossier
    for f in /app/ssh/; do
        # ssh-agent add key
        ssh-add "$f"
        echo "Found ssh key. Added with ssh-agent: $f"
    done
fi

if [ ! -d "/app/scripts" ]
then
    sudo -u alpine mkdir /app/scripts
else
    for f in /app/scripts/*.sh; do
        # On rend exécutable les fichiers trouvés
        chmod a+x "$f"
        echo "Found script file: $f"
    done
fi

if [ ! -d "/app/periodic" ]
then
    sudo -u alpine mkdir /app/periodic
    # 15min daily hourly monthly weekly
    # Liens symbolic venant de /etc/periodic
    sudo -u alpine ln -s /etc/periodic/15min /app/periodic/15min
    sudo -u alpine ln -s /etc/periodic/daily /app/periodic/daily
    sudo -u alpine ln -s /etc/periodic/hourly /app/periodic/hourly
    sudo -u alpine ln -s /etc/periodic/monthly /app/periodic/monthly
    sudo -u alpine ln -s /etc/periodic/weekly /app/periodic/weekly

fi