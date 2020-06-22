---
dovecot:
  pkg.installed:
    - pkgs:
      - dovecot
  service.running:
    - enable: True
