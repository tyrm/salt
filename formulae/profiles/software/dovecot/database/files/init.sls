---
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
