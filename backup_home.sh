#!/bin/bash

HEMKATALOG="$HOME/" #Hemkatlogen
ANVANDARE="ilivus" #användarnamn på Linns server
IP="192.168.214.64" #Linns IP
SOKVAG="/amanda" #sökväg till backuppmappen på Linns server
BACKUP_MAPP="backup"  #min backupmapp
ARKIV_MAPP="arkiv"  #här sparas gamla/raderade filer
DATUM=$(date +%Y-%m-%d)
GAMMAL="gammal_$DATUM"

#skapar mappar på Linns server om det inte redan finns
ssh "$ANVANDARE@$IP" "mkdir -p '$SOKVAG/$BACKUP_MAPP/$ARKIV_MAPP/$GAMMAL'"

#RSYNC
rsync -av --delete --backup --backup-dir="$SOKVAG/$BACKUP_MAPP/$ARKIV_MAPP/$GAMMAL" --exclude="$ARKIV_MAPP/" "$HEMKATALOG" "$ANVANDARE@$IP:$SOKVAG/$BACKUP_MAPP"

echo "Backup klar!"
echo "Gamla filer sparas i: $SOKVAG/$ARKIV_MAPP/$GAMMAL"
