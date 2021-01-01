---
dovecot:
  auth:
    auth_mechanisms: plain login
    service:
      unix_listeners:
        - path: /var/spool/postfix/private/auth
          mode: "0666"
    user_database: sql
  lmtpd:
    protocol:
      mail_plugins: $mail_plugins sieve
    service:
      unix_listeners:
        - path: /var/spool/postfix/private/dovecot-lmtp
          group: postfix
          mode: "0600"
          user: postfix
  mail_gid: 500
  mail_uid: 500
  plugin:
    antispam_backend: pipe
    antispam_spam: Junk
    antispam_trash: Trash
    antispam_mail_sendmail: /usr/local/bin/rspamc
    antispam_mail_spam: learn_spam
    antispam_mail_notspam: learn_ham
    antispam_mail_sendmail_args: "-h;localhost:11334;-P;q1"
  sieve:
    sieve_before: /usr/local/etc/dovecot/sieve/before.d
    sieve_extensions: +spamtest +spamtestplus
    sieve_spamtest_status_type: score
    sieve_spamtest_status_header: "X-Spamd-Result: default: [[:alnum:]]+ \\[(-?[[:digit:]]+\\.[[:digit:]]+) / -?[[:digit:]]+\\.[[:digit:]]+\\]"
    sieve_spamtest_max_header: "X-Spamd-Result: default: [[:alnum:]]+ \\[-?[[:digit:]]+\\.[[:digit:]]+ / (-?[[:digit:]]+\\.[[:digit:]]+)\\]"
  sql:
    dbname: {{ dbname }}
    default_pass_scheme: SHA512
    driver: pgsql
    hostname: {{ dbhost }}
    password_query: >
      SELECT username, domain, password FROM mxboxes WHERE username = '%n' AND domain = '%d'
    user_query: >
      SELECT 'maildir:/var/lib/mailboxes/'||id as mail, '/var/lib/mailboxes/'||id as home, 500 as uid, 500 as gid FROM mxboxes WHERE username = '%n' AND domain = '%d'
    username: {{ dbuser }}
  ssl:
    ssl_dh: /etc/dovecot/dh.pem

opendkim:
  socket: inet:12301@localhost

postfix:
  alias_maps: "hash:/etc/postfix/aliases"
  enable_smtps: true
  enable_submission: true
  inet_interfaces: all
  local_recipient_maps: "hash:/etc/postfix/boxes $alias_maps"
  mailbox_transport: "lmtp:unix:private/dovecot-lmtp"
  milter_default_action: accept
  milter_mail_macros: i {mail_addr} {client_addr} {client_name} {auth_authen} {auth_type}
  mydestination: $myhostname, localhost.$mydomain, localhost, $mydomain
  mynetworks: "127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128"
  myorigin: $mydomain
  non_smtpd_milters: "inet:127.0.0.1:11332, inet:localhost:12301"
  smtp_tls_security_level: may
  smtp_tls_session_cache_database: "btree:${data_directory}/smtp_scache"
  smtpd_milters: "inet:127.0.0.1:11332, inet:localhost:12301"
  smtpd_sasl_auth_enable: "yes"
  smtpd_sasl_path: private/auth
  smtpd_sasl_type: dovecot
  smtpd_tls_protocols: "!SSLv2, !SSLv3"
  smtpd_tls_session_cache_database: "btree:${data_directory}/smtpd_scache"
  smtpd_tls_security_level: encrypt
  smtpd_use_tls: "yes"
  virtual_alias_maps: "hash:/etc/postfix/virtaliases"

rspamd:
  antivirus: >
    clamav {
     attachments_only = false;
     symbol = "CLAM_VIRUS";
     type = "clamav";
     action = "reject";
     servers = "/var/run/clamav/clamd.ctl";
    }
  mailter_headers: >
    extended_spam_headers = true;
