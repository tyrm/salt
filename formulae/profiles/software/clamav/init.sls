---
clamav:
  pkg.installed:
    - pkgs:
      - clamav
      - clamav-daemon

clamav-freshclam:
  service.running:
    - enable: True
    - watch:
      - pkg: clamav
