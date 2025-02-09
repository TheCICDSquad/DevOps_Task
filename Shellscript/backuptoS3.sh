#!/bin/bash

# Set variables
PG_USER="admin"  
PG_HOST="localhost"
PG_PORT="5432"   
S3_BUCKET=""  
BACKUP_DIR="/tmp/s3_pg_backups" 

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Get the list of databases
databases=$(psql -U "$PG_USER" -h "$PG_HOST" -p "$PG_PORT" -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;")

# Loop through each database and backup
for db in $databases; do
  echo "Backing up database: $db"

  # Define backup file path
  BACKUP_FILE="$BACKUP_DIR/$db.sql"

  # Backup the database using pg_dump
  pg_dump -U "$PG_USER" -h "$PG_HOST" -p "$PG_PORT" "$db" -F c -f "$BACKUP_FILE"

  # Check if pg_dump was successful
  if [ $? -eq 0 ]; then
    echo "Backup successful for database: $db"
  else
    echo "Backup failed for database: $db"
    continue
  fi

  # Compress the backup file
  BACKUP_ZIP="$BACKUP_FILE.gz"
  gzip -c "$BACKUP_FILE" > "$BACKUP_ZIP"

  # Check if compression was successful
  if [ $? -eq 0 ]; then
    echo "Compression successful for database: $db"
  else
    echo "Compression failed for database: $db"
    continue
  fi

  # Upload the compressed backup to S3
  aws s3 cp "$BACKUP_ZIP" "$S3_BUCKET/$db-$(date +%Y-%m-%d_%H-%M-%S).gz"

  # Check if upload was successful
  if [ $? -eq 0 ]; then
    echo "Successfully uploaded $db backup to S3"
  else
    echo "Failed to upload $db backup to S3"
  fi

  # Clean up local backup files
  rm -f "$BACKUP_FILE" "$BACKUP_ZIP"
done

echo "Backup process completed!"
