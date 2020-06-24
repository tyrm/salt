
postfix-pgsql:
  pkg.installed:
    - pkgs:
      - postfix-pgsql
    - require:
      - pkg: postfix
    - watch_in:
      - service: postfix

{% for key, pgconf in salt['pillar.get']('postfix:pgconfs', {}).items() %}
/etc/postfix/pgsql-{{ key }}.cf:
  file.managed:
    - context:
        hosts: {{ pgconf.hosts }}
        user: {{ pgconf.user }}
        password: {{ pgconf.password }}
        dbname: {{ pgconf.dbname }}
        query: {{ pgconf.query }}
    - group: root
    - mode: 644
    - source: salt://profiles/software/postfix/pgsql/files/pgsql.cf.j2
    - template: jinja
    - user: root
    - require:
      - pkg: postfix
    - watch_in:
      - service: postfix
{% endfor %}
