---
dovecot:
  lmtpd:
    protocol:
      hostname: util1.ptzo.gdn
      postmaster_address: postmaster@pettingzoo.co
  mail_plugins: $mail_plugins fts fts_solr
  plugin:
    fts: solr
    fts_solr: url=http://localhost:8983/solr/mail/
  ssl:
    ssl_cert: /etc/letsencrypt/live/util1.ptzo.gdn/fullchain.pem
    ssl_key: /etc/letsencrypt/live/util1.ptzo.gdn/privkey.pem

opendkim:
  domains:
    faery.pub:
      domainkey: 20200629
    pettingzoo.co:
      domainkey: 20200630
    pup.haus:
      domainkey: 20200626

postfix:
  mydestination: $myhostname, localhost.$mydomain, localhost, $mydomain
  mydomain: pettingzoo.co
  myhostname: util1.ptzo.gdn
  smtpd_tls_cert_file: /etc/letsencrypt/live/util1.ptzo.gdn/fullchain.pem
  smtpd_tls_key_file: /etc/letsencrypt/live/util1.ptzo.gdn/privkey.pem
  virtual_alias_domains: faery.pub pup.haus

postgresql:
  hba_extra_lines: |
      host all all all md5
  listen_addresses: '*'
  ssl_cert_file: /etc/postgresql/12/main/server.crt
  ssl_key_file: /etc/postgresql/12/main/server.key
