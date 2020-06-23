---
clamav:
  pkg.installed:
    - pkgs:
      - clamav

clamav-freshclam:
  service.running:
    - enable: True
    - watch:
      - pkg: clamav
