---
mail pguser:
  postgres_user.present:
    - login: True
    - name: {{ salt['pillar.get']('dovecot:sql:user', 'mail') }}
    - password: {{ pillar['dovecot']['sql']['password'] }}
