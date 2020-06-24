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

{% set confs = ['main.cf', 'master.cf'] %}
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
