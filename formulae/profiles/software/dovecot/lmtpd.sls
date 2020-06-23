---
dovecot-lmtdp:
  pkg.installed:
    - pkgs:
      - dovecot-lmtdp
    - watch_in:
      - service: dovecot
