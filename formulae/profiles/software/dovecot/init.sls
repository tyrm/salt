---
dovecot:
  pkg.installed:
    - pkgs:
      - dovecot-core
  service.running:
    - enable: True
