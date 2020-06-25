---
dovecot-managesieved:
  pkg.installed:
    - pkgs:
      - dovecot-managesieved
    - watch_in:
      - service: dovecot
