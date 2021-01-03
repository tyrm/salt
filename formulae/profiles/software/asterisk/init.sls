---
asterisk:
  pkg.installed:
    - pkgs:
      - asterisk
  service.running:
    - enable: True
    - watch:
      - pkg: asterisk
