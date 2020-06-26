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

/etc/opendkim.conf:
  file.managed:
    - mode: 644
    - source: salt://profiles/software/opendkim/files/opendkim.conf.j2
    - template: jinja
    - require:
      - pkg: opendkim
    - watch_in:
      - service: opendkim

/etc/opendkim:
  file.directory:
    - require:
      - pkg: opendkim

/etc/opendkim/TrustedHosts:
  file.managed:
    - mode: 644
    - source: salt://profiles/software/opendkim/files/TrustedHosts.j2
    - template: jinja
    - require:
      - file: /etc/opendkim
      - pkg: opendkim
    - watch_in:
      - service: opendkim

/etc/opendkim/KeyTable:
  file.managed:
    - mode: 644
    - source: salt://profiles/software/opendkim/files/KeyTable.j2
    - template: jinja
    - require:
      - file: /etc/opendkim
      - pkg: opendkim
    - watch_in:
      - service: opendkim

/etc/opendkim/SigningTable:
  file.managed:
    - mode: 644
    - source: salt://profiles/software/opendkim/files/SigningTable.j2
    - template: jinja
    - require:
      - file: /etc/opendkim
      - pkg: opendkim
    - watch_in:
      - service: opendkim
