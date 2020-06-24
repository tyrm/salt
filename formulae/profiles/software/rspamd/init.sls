---
rspamd:
  pkg.installed:
    - pkgs:
      - rspamd
  service.running:
    - enable: True
    - watch:
      - pkg: rspamd
