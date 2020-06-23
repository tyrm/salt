---
clamav:
  pkg.installed:
    - pkgs:
      - clamav

clamd:
  service.running:
    - enable: True
    - watch:
      - pkg: clamav
