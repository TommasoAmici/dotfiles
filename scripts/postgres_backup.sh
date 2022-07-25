#!/bin/sh
#
# A script to backup and encrypt postgres databases

BASE_DIR="/var/lib/postgresql"
cd $BASE_DIR || exit 1

# An .env file with BACKUP_ENCRYPTION_KEY is required
ENV_FILE="$BASE_DIR/.env"
if [ -f "$ENV_FILE" ]; then
  . "$ENV_FILE"
else
  exit 1
fi

BACKUP_DIR="$BASE_DIR/backups"

# date in ISO format
DATE=$(date -I)

DATABASES="
  #XXX
  example_1
  example_2
"

for DB in $DATABASES; do
  FILENAME="$BACKUP_DIR/$DATE-$DB.sql.zst.aes"
  pg_dump --clean --no-owner "$DB" | zstd | openssl enc -e -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -out "$FILENAME"
done

# delete backups older than two days
find "$BASE_DIR" -mtime +2 -type f -delete

# To decrypt and uncompress backup run this command
# openssl enc -d -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -in BACKUP_DIR.tar.zst | tar -x
