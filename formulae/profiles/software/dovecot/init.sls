---
dovecot:
  pkg.installed:
    - pkgs:
      - dovecot-core
  service.running:
    - enable: True
    - watch:
      - pkg: dovecot

/etc/dovecot/dovecot-sql.conf.ext:
  file.managed:
    - group: dovecot
    - mode: 640
    - source: salt://profiles/software/dovecot/files/dovecot-sql.conf.ext.j2
    - template: jinja
    - user: root
    - require:
      - pkg: dovecot
    - watch_in:
      - service: dovecot

/etc/dovecot/conf.d/10-auth.conf:
  file.managed:
    - group: root
    - mode: 644
    - source: salt://profiles/software/dovecot/files/10-auth.conf.j2
    - template: jinja
    - user: root
    - require:
      - pkg: dovecot
    - watch_in:
      - service: dovecot

/etc/dovecot/conf.d/10-ssl.conf:
  file.managed:
    - group: root
    - mode: 644
    - source: salt://profiles/software/dovecot/files/10-ssl.conf.j2
    - template: jinja
    - user: root
    - require:
      - pkg: dovecot
    - watch_in:
      - service: dovecot
