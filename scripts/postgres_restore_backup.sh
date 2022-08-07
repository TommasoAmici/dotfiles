#!/bin/sh
#
# A script to restore encrypted backups of postgres databases

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

DATABASES="
  #XXX
  example_1
  example_2
"

for DB_NAME in $DATABASES; do
  DB_USER=DB_NAME
  DB_PASS=DB_NAME

  FILENAME_PATTERN="*-$DB_NAME.sql.zst.aes"
  BACKUP_FILE=$(find "$BACKUP_DIR" -name "$FILENAME_PATTERN" -printf '%p\n' | sort -r | head -1)

  psql postgres \
    -c "DROP DATABASE IF EXISTS ${DB_NAME} (FORCE)" \
    -c "DROP USER IF EXISTS ${DB_USER}"

  psql postgres \
    -c "CREATE USER ${DB_USER} CREATEDB PASSWORD '${DB_PASS}'" \
    -c "CREATE DATABASE ${DB_NAME} OWNER ${DB_USER}"

  openssl enc -d -aes256 -salt -pbkdf2 -pass "pass:$BACKUP_ENCRYPTION_KEY" -in "$BACKUP_FILE" | zstd -dc | psql -U "$DB_USER" "$DB_NAME"
done
