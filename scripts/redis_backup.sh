#!/bin/sh
#
# A script to create an encrypted backup of a Redis instance

# current date in ISO format
DATE=$(date -I)

BASE_DIR="/backups"
BACKUP_DIR="$BASE_DIR/redis"
FILENAME="$DATE-dump.rdb"
FILEPATH="$BACKUP_DIR/$FILENAME"

# An .env file with BACKUP_ENCRYPTION_KEY is required
ENV_FILE="$BASE_DIR/.env"
if [ -f "$ENV_FILE" ]; then
  . "$ENV_FILE"
else
  exit 1
fi

# create date stamped backup
redis-cli --rdb "$FILEPATH"

cd "$BACKUP_DIR" &&
  zstd -c "$FILENAME" |
  openssl enc -e -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -out "$FILENAME.zst.aes" &&
  rm "$FILENAME"

# delete backups older than two days
find /backups/redis/ -mtime +2 -type f -delete

# To decrypt and uncompress backup run this command
# openssl enc -d -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -in BACKUP_DIR.tar.zst | tar -x
