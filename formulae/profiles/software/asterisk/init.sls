---
asterisk:
  pkg.installed:
    - pkgs:
      - asterisk
  service.running:
    - enable: True
    - watch:
      - pkg: asterisk

{% set confs = ['sip.conf'] %}
{% for conf in confs %}
/etc/asterisk/{{ conf }}:
  file.managed:
    - group: asterisk
    - mode: 644
    - source: salt://profiles/software/asterisk/files/{{ conf }}.j2
    - template: jinja
    - user: asterisk
    - require:
      - pkg: asterisk
    - watch_in:
      - service: asterisk
{% endfor %}
