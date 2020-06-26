---
opendkim:
  pkg.installed:
    - pkgs:
      - opendkim
      - opendkim-tools
  service.running:
    - enable: True
    - watch:
      - pkg: opendkim
