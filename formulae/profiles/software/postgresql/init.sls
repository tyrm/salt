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

/etc/postgresql/12/main/postgresql.conf:
  file.managed:
    - group: postgres
    - mode: 644
    - source: salt://profiles/software/postgresql/files/postgresql.conf.j2
    - template: jinja
    - user: postgres
    - require:
      - pkg: postgresql
    - watch_in:
      - service: postgresql
