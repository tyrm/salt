---
mail pguser:
  postgres_user.present:
    - login: True
    - name: {{ salt['pillar.get']('dovecot:sql:user', 'mail') }}
    - password: {{ pillar['dovecot']['sql']['password'] }}

mail pgdb:
  postgres_database.present:
    - name: {{ salt['pillar.get']('dovecot:sql:dbname', 'mail') }}
    - owner: {{ salt['pillar.get']('dovecot:sql:user', 'mail') }}
