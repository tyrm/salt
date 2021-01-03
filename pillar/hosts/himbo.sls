---
asterisk:
  ca:
    country: US
    state: California
    locality: The Gay Area
    organization: The Hive
    server_common: sip.hive.gay

dovecot:
  lmtpd:
    protocol:
      hostname: himbo.hive.gay
      postmaster_address: postmaster@hive.gay
  mail_plugins: $mail_plugins fts fts_solr
  plugin:
    fts: solr
    fts_solr: url=http://localhost:8983/solr/mail/
  ssl:
    ssl_cert: /etc/letsencrypt/live/himbo.hive.gay/fullchain.pem
    ssl_key: /etc/letsencrypt/live/himbo.hive.gay/privkey.pem

opendkim:
  domains:
    hive.gay:
      domainkey: 20201231

postfix:
  mydestination: $myhostname, localhost.$mydomain, localhost, $mydomain
  mydomain: hive.gay
  myhostname: himbo.hive.gay
  smtpd_tls_cert_file: /etc/letsencrypt/live/himbo.hive.gay/fullchain.pem
  smtpd_tls_key_file: /etc/letsencrypt/live/himbo.hive.gay/privkey.pem

postgresql:
  hba_extra_lines: |
      host all all all md5
  listen_addresses: '*'
  ssl_cert_file: /etc/postgresql/12/main/server.crt
  ssl_key_file: /etc/postgresql/12/main/server.key

users:
  tyr:
    groups:
      - adm
      - cdrom
      - sudo
      - dip
      - plugdev
      - lxd
      - docker
