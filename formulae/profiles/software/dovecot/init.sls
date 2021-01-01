---
dovecot:
  pkg.installed:
    - pkgs:
      - dovecot-core
  service.running:
    - enable: True
    - watch:
      - pkg: dovecot

openssl dhparam -out /etc/dovecot/dh.pem 4096:
  cmd.run:
    - creates: /etc/dovecot/dh.pem
    - require:
      - pkg: dovecot
    - watch_in:
      - service: dovecot

{% set confs = ['10-auth.conf', '10-mail.conf', '10-master.conf', '10-ssl.conf', '90-plugin.conf'] %}
{% for conf in confs %}
/etc/dovecot/conf.d/{{ conf }}:
  file.managed:
    - group: root
    - mode: 644
    - source: salt://profiles/software/dovecot/files/{{ conf }}.j2
    - template: jinja
    - user: root
    - require:
      - pkg: dovecot
    - watch_in:
      - service: dovecot
{% endfor %}
