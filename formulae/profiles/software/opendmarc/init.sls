---
opendmarc:
  pkg.installed:
    - pkgs:
      - opendmarc
  service.running:
    - enable: True
    - watch:
      - pkg: opendmarc
