---
dovecot-solr:
  pkg.installed:
    - pkgs:
      - dovecot-solr
    - watch_in:
      - service: dovecot
