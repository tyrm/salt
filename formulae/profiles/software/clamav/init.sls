---
clamav:
  pkg.installed:
    - pkgs:
      - clamav
      - clamav-daemon

clamav-daemon:
  service.running:
    - enable: True
    - watch:
      - pkg: clamav

clamav-freshclam:
  service.running:
    - enable: True
    - watch:
      - pkg: clamav
