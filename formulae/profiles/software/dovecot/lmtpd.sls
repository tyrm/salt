---
dovecot-lmtpd:
  pkg.installed:
    - pkgs:
      - dovecot-lmtpd
    - watch_in:
      - service: dovecot
