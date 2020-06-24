---
dovecot:
  auth:
    user_database: sql
  lmtpd:
    protocol:
      hostname: backyard.pup.haus
      postmaster_address: postmaster@pup.haus
    service:
      unix_listeners:
        - path: /var/spool/postfix/private/dovecot-lmtp
          group: postfix
          mode: 0600
          user: postfix
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
  ssl:
    ssl_dh: /etc/dovecot/dh.pem
