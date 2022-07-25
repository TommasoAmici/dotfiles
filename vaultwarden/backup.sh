#!/bin/sh

# This script backs up and encrypts data from vaultwarden running in Docker with a SQLite
# database

BASE_DIR="#XXX"
# An .env file with BACKUP_ENCRYPTION_KEY is required
ENV_FILE="$BASE_DIR/.env"

if [ -f "$ENV_FILE" ]; then
  . "$ENV_FILE"
else
  exit 1
fi

# current date in ISO format
BACKUP_DIR_BASENAME=$(date -I)

DATA_DIR="$BASE_DIR/#XXX"
BACKUPS_DIR="$BASE_DIR/backups"
BACKUP_DIR="$BACKUPS_DIR/$BACKUP_DIR_BASENAME"
mkdir -p "$BACKUP_DIR"

sqlite3 "$DATA_DIR/db.sqlite3" ".backup $BACKUP_DIR/db.sqlite3"
cp -R "$DATA_DIR/attachments" "$BACKUP_DIR/attachments"
cp -R "$DATA_DIR/sends" "$BACKUP_DIR/sends"
cp "$DATA_DIR/config.json" "$BACKUP_DIR/config.json"

for FILEPATH in "$DATA_DIR"/rsa_key*; do
  FILENAME=$(basename "$FILEPATH")
  cp "$DATA_DIR/$FILENAME" "$BACKUP_DIR/$FILENAME"
done

# compress and encrypt directory with data
cd "$BACKUPS_DIR" &&
  tar --zstd -cf - "$BACKUP_DIR_BASENAME" |
  openssl enc -e -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -out "$BACKUP_DIR_BASENAME.tar.zst"
rm -r "$BACKUP_DIR"

# delete backups older than two days
find "$BACKUPS_DIR" -mtime +2 -type f -delete

# To decrypt and uncompress backup run this command
# openssl enc -d -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -in BACKUP_DIR.tar.zst | tar -x
