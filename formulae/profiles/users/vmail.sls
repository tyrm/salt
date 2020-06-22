---
include:
  - profiles.groups.vmail

vmail:
  user.present:
    - gid: 500
    - shell: /usr/sbin/nologin
    - system: True
    - uid: 500
    - require:
      - group: vmail
