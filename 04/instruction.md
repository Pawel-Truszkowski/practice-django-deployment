## CI/CD

Projekt używa GitHub Actions do automatycznego wdrożenia na serwer
po każdym pushu do gałęzi `main`.

### Wymagane Secrets


|
 Secret 
|
 Opis 
|
|
---
|
---
|
|
`SSH_HOST`
|
 Adres IP lub domena serwera 
|
|
`SSH_USER`
|
 Nazwa użytkownika SSH 
|
|
`SSH_PRIVATE_KEY`
|
 Klucz prywatny SSH (zawartość pliku 
`id_rsa`
 lub 
`id_ed25519`
) 
|
|
`SSH_PORT`
|
 Port SSH (domyślnie 
`22`
) 
|

### Pierwszy deploy

1. Skonfiguruj Secrets w: Settings → Secrets and variables → Actions
2. Na serwerze sklonuj repozytorium:
```bash
   git clone git@github.com:twoj-user/projekt.git /home/deploy/projekt
```
3. Utwórz plik `.env` na serwerze w katalogu projektu
4. Zrób push do `main` — workflow uruchomi się automatycznie

### Weryfikacja

Po zakończeniu workflow sprawdź na serwerze:
```bash
docker ps                          # kontenery działają
docker compose logs web            # logi aplikacji
docker compose logs nginx          # logi nginx
```