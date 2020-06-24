---
include:
  - profiles.users.vmail

postfix:
  pkg.installed:
    - pkgs:
      - postfix
    - require:
      - user: vmail
  service.running:
    - enable: True
    - watch:
      - pkg: postfix

{% set confs = ['main.cf'] %}
{% for conf in confs %}
/etc/postfix/{{ conf }}:
  file.managed:
    - group: root
    - mode: 644
    - source: salt://profiles/software/postfix/files/{{ conf }}.j2
    - template: jinja
    - user: root
    - require:
      - pkg: postfix
    - watch_in:
      - service: postfix
{% endfor %}

{% set pgconfs = salt['pillar.get']('postfix:pgconfs', []) %}
{% for pgconf in pgconfs %}
/etc/postfix/pgsql-{{ pgconf.name }}.cf:
  file.managed:
    - context: pgconf
    - group: root
    - mode: 644
    - source: salt://profiles/software/postfix/files/pgsql.cf.j2
    - template: jinja
    - user: root
    - require:
      - pkg: postfix
    - watch_in:
      - service: postfix
{% endfor %}
