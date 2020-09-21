{% set groups_list = salt['pillar.get']('users:tyr:groups', ['sudo'])  %}
---
tyr:
  user.present:
    - groups: {{ groups_list }}
    - require:
      - group: tyr
  group.present
