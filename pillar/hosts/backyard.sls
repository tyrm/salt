---
dovecot:
  lmtpd:
    protocol:
      hostname: backyard.pup.haus
      postmaster_address: postmaster@pup.haus
  mail_plugins: $mail_plugins fts fts_solr
  plugin:
    fts: solr
    fts_solr: url=http://localhost:8983/solr/mail/
  ssl:
    ssl_cert: /etc/letsencrypt/live/pup.haus/fullchain.pem
    ssl_key: /etc/letsencrypt/live/pup.haus/privkey.pem

opendkim:
  domains:
    pup.haus:
      domainkey: 20200626

postfix:
  mydestination: $myhostname, localhost.$mydomain, localhost, $mydomain, faery.pub
  mydomain: pup.haus
  myhostname: backyard.pup.haus
  smtpd_tls_cert_file: /etc/letsencrypt/live/pup.haus/fullchain.pem
  smtpd_tls_key_file: /etc/letsencrypt/live/pup.haus/privkey.pem
  virtual_alias_domains: faery.pub

postgresql:
  hba_extra_lines: |
      host all all all md5
  listen_addresses: '*'
  ssl_cert_file: /etc/postgresql/12/main/server.crt
  ssl_key_file: /etc/postgresql/12/main/server.key
