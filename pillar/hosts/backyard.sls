---
dovecot:
  ssl:
    ssl_cert: /etc/letsencrypt/live/pup.haus/fullchain.pem
    ssl_key: /etc/letsencrypt/live/pup.haus/privkey.pem


postgresql:
  hba_extra_lines: |
      host all all all md5
  listen_addresses: '*'
  ssl_cert_file: /etc/postgresql/12/main/server.crt
  ssl_key_file: /etc/postgresql/12/main/server.key
