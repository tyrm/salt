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

/etc/opendkim/keys:
  file.directory:
    - group: opendkim
    - mode: 640
    - user: opendkim
    - require:
      - file: /etc/opendkim

{%- for key, conf in salt['pillar.get']('opendkim:domains', {}).items() %}
/etc/opendkim/keys/{{ key }}:
  file.directory:
    - group: opendkim
    - mode: 640
    - user: opendkim
    - require:
      - file: /etc/opendkim/keys

opendkim-genkey -s {{ conf.domainkey }} -d {{ key }}:
  cmd.run:
    - creates:
      - /etc/opendkim/keys/{{ key }}/{{ conf.domainkey }}
    - cwd: /etc/opendkim/keys/{{ key }}
    - require:
      - file: /etc/opendkim/keys/{{ key }}
    - watch_in:
      - service: opendkim
{%- endfor -%}
