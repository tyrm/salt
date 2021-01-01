---
include:
  - profiles.software.clamav
  - profiles.software.dovecot
  - profiles.software.dovecot.antispam
  - profiles.software.dovecot.imapd
  - profiles.software.dovecot.lmtpd
  - profiles.software.dovecot.managesieved
  - profiles.software.dovecot.sieve
  - profiles.software.dovecot.solr
  - profiles.software.opendkim
  - profiles.software.opendmarc
  - profiles.software.postfix
  - profiles.software.rspamd
  - profiles.users.vmail

/var/lib/mailboxes:
  file.directory:
    - user: vmail
    - group: vmail
