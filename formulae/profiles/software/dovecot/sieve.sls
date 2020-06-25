---
dovecot-sieve:
  pkg.installed:
    - pkgs:
      - dovecot-sieve
    - watch_in:
      - service: dovecot
