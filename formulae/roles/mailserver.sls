---
include:
  - profiles.postgresql.mailserver
  - profiles.software.clamav
  - profiles.software.dovecot
  - profiles.software.dovecot.imapd
  - profiles.software.dovecot.lmtpd
  - profiles.software.dovecot.pgsql
  - profiles.software.dovecot.sieve
  - profiles.software.postfix
  - profiles.software.postfix.pgsql
  - profiles.software.postgresql
  - profiles.software.rspamd
  - profiles.users.vmail

/var/lib/mailboxes:
  file.directory:
    - user: vmail
    - group: vmail
