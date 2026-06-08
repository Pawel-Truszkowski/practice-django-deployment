## Backup bazy danych

### Zmienne środowiskowe

Skrypt korzysta z tych samych zmiennych co aplikacja (plik `.env`):

| Zmienna | Domyślna wartość | Opis |
|---|---|---|
| `DB_NAME` | `postgres` | Nazwa bazy danych |
| `DB_USER` | `postgres` | Użytkownik bazy danych |
| `COMPOSE_SERVICE` | `db` | Nazwa serwisu w docker-compose |

### Ręczne uruchomienie

```bash
./backup.sh
```

### Konfiguracja crona

Otwórz edytor crona:
```bash
crontab -e
```

Dodaj linię (backup codziennie o 02:00):

```bash
0 2 * * * cd /home/user/project && ./backup.sh >> /home/user/project/backups/cron.log 2>&1
```

Sprawdź czy cron jest dodany:
```bash
crontab -l
```

### Weryfikacja backupu

```bash
# Lista backupów
ls -lh backups/

# Sprawdź zawartość backupu
head -20 backups/backup_20260607_0200.sql
```

Prawidłowy backup zaczyna się od linii:

-- PostgreSQL database dump
