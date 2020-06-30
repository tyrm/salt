---
dovecot-sieve:
  pkg.installed:
    - pkgs:
      - dovecot-sieve
    - watch_in:
      - service: dovecot

/etc/dovecot/conf.d/90-sieve.conf:
  file.managed:
    - group: root
    - mode: 644
    - source: salt://profiles/software/dovecot/sieve/files/90-sieve.conf.j2
    - template: jinja
    - user: root
    - watch_in:
      - service: dovecot
