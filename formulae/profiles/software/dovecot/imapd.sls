---
dovecot-imapd:
  pkg.installed:
    - pkgs:
      - dovecot-imapd
    - watch_in:
      - service: dovecot
