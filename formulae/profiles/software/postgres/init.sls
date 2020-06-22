---
postgresql:
  pkg.installed:
    - pkgs:
      - postgresql
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: postgresql
