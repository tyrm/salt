---
{% set dbhost = 'localhost '%}
{% set dbname = 'mail '%}
{% set dbuser = 'mail '%}
dovecot:
  auth:
    service:
      unix_listeners:
        - path: /var/spool/postfix/private/auth
          mode: 0666
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
    dbname: {{ dbname }}
    default_pass_scheme: SHA512
    driver: pgsql
    hostname: {{ dbhost }}
    password_query: >
      SELECT username, domain, password FROM users WHERE username = '%n' AND domain = '%d'
    user_query: >
      SELECT 'maildir:/var/lib/mailboxes/'||id as mail, '/var/lib/mailboxes/'||id as home, 500 as uid, 500 as gid FROM mxboxes WHERE username = '%n' AND domain = '%d'
    username: {{ dbuser }}
  ssl:
    ssl_dh: /etc/dovecot/dh.pem

postfix:
  alias_maps: "proxy:pgsql:/etc/postfix/pgsql-aliases.cf"
  inet_interfaces: all
  local_recipient_maps: "proxy:pgsql:/etc/postfix/pgsql-boxes.cf $alias_maps"
  mailbox_transport: "lmtp:unix:private/dovecot-lmtp"
  mydestination: $myhostname, localhost.$mydomain, localhost, $mydomain
  mydomain: pup.haus
  myhostname: backyard.pup.haus
  mynetworks: "127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128"
  myorigin: $mydomain
  pgconfs:
    aliases:
      hosts: {{ dbhost }}
      user: {{ dbuser }}
      dbname: {{ dbname }}
      query: SELECT forw_addr FROM mxaliases WHERE alias='%s'
    boxes:
      hosts: {{ dbhost }}
      user: {{ dbuser }}
      dbname: {{ dbname }}
      query: SELECT email FROM vw_mxboxes WHERE username = '%n' AND domain = '%d'
  smtp_tls_session_cache_database: "btree:${data_directory}/smtp_scache"
  smtpd_sasl_auth_enable: "yes"
  smtpd_sasl_path: private/auth
  smtpd_sasl_type: dovecot
  smtpd_tls_cert_file: /etc/letsencrypt/live/pup.haus/fullchain.pem
  smtpd_tls_key_file: /etc/letsencrypt/live/pup.haus/privkey.pem
  smtpd_tls_protocols: "!SSLv2, !SSLv3"
  smtpd_tls_session_cache_database: "btree:${data_directory}/smtpd_scache"
  smtpd_tls_security_level: encrypt
  smtpd_use_tls: "yes"
