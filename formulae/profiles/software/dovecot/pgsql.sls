---
dovecot-pgsql:
  pkg.installed:
    - pkgs:
      - dovecot-pgsql
    - watch_in:
      - service: dovecot
