---
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
