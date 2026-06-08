#!/bin/bash

# Zmienne środowiskowe (z pliku .env lub ustawione w systemie)
DB_NAME=${DB_NAME:-postgres}
DB_USER=${DB_USER:-postgres}
COMPOSE_SERVICE=${COMPOSE_SERVICE:-db}
BACKUP_DIR="$(dirname "$0")/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M")
BACKUP_FILE="$BACKUP_DIR/backup_${TIMESTAMP}.sql"

# Utwórz katalog jeśli nie istnieje
mkdir -p "$BACKUP_DIR"

echo "Rozpoczecie backup bazy '$DB_NAME'..."

# Wykonaj pg_dump przez docker compose
docker compose exec -T "$COMPOSE_SERVICE" \
    pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"

# Sprawdź czy backup się udał
if [ $? -ne 0 ]; then
    echo "BŁĄD: backup nie powiódł się!"
    rm -f "$BACKUP_FILE"   # usuń pusty plik
    exit 1
fi

# Sprawdź czy plik nie jest pusty
if [ ! -s "$BACKUP_FILE" ]; then
    echo "BŁĄD: plik backupu jest pusty!"
    rm -f "$BACKUP_FILE"
    exit 1
fi

echo "Backup zapisany: $BACKUP_FILE"

# Usuń backupy starsze niż 7 dni
echo "Czyszczenie starych backupów..."
find "$BACKUP_DIR" -type f -name "*.sql" -mtime +7 -delete

echo "Gotowe!"
