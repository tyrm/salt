---
dovecot:
  sql:
    dbname: mail
    default_pass_scheme: SHA512
    driver: pgsql
    hostname: localhost
    password_query: >
      SELECT username, domain, password FROM users WHERE username = '%n' AND domain = '%d'
    user_query: >
      SELECT 'maildir:/var/lib/mailboxes/'||maildir as mail, '/var/lib/mailboxes/'||maildir as home, 500 as uid, 500 as gid FROM users WHERE username = '%n' AND domain = '%d'
    username: mail

postgresql:
  listen_addresses: '*'
  ssl_cert_file: /etc/letsencrypt/live/pup.haus/fullchain.pem
  ssl_key_file: /etc/letsencrypt/live/pup.haus/privkey.pem
