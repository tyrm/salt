---
dovecot-antispam:
  pkg.installed:
    - pkgs:
      - dovecot-antispam
    - watch_in:
      - service: dovecot
