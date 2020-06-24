---
rspamd:
  pkg.installed:
    - pkgs:
      - rspamd
  service.running:
    - enable: True
    - watch:
      - pkg: rspamd

/etc/rspamd/override.d/milter_headers.conf:
{% if salt['pillar.get']('rspamd:mailter_headers', False) %}
  file.managed:
    - group: root
    - mode: 644
    - contents_pillar: rspamd:mailter_headers
    - template: jinja
    - user: root
{% else %}
  file.absent:
{% endif %}
    - require:
      - pkg: rspamd
    - watch_in:
      - service: rspamd
