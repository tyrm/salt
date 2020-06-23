---
dovecot-imapd:
  pkg.installed:
    - pkgs:
      - dovecot-imapd
    - watch_in:
      - service: dovecot

/etc/dovecot/conf.d/20-lmtp.conf:
  file.managed:
    - group: root
    - mode: 644
    - source: salt://profiles/software/dovecot/lmtpd/files/20-lmtp.conf.j2
    - template: jinja
    - user: root
    - watch_in:
      - service: dovecot
