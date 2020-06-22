---
include:
  - profiles.users.vmail

postfix:
  pkg.installed:
    - pkgs:
      - postfix
    - require:
      - user: vmail
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: postfix
