{% set groups_list = salt['pillar.get']('users:tyr:groups', ['sudo'])  %}
---
tyr:
  user.present:
    - groups: {{ groups_list }}
    - require:
      - group: tyr
  group.present:
    - name: tyr

tyr sshkey fenrir:
  ssh_auth.present:
    - user: tyr
    - enc: ssh-rsa
    - comment: tyr@fenrir
    - name: AAAAB3NzaC1yc2EAAAADAQABAAABgQCjo3N2M6LaG73j3F8CfqNQ2divajw2O9HYDqFGZRfFU1FbvockTPbKT7dhY2L1FrHfUkkC3CPkCCZd9+sA+0uKnYo7jmeMc+Jjs+iLnn5X6ljuxGa5F2RQhFzFLBMPxT/hdpPhP7qTt2AH5phsheL8uE9PDtRRqM7sH8UvSkAbQIAgt0OkB0rYf0vwpH83tVVvpi5d2hgn0ViMDgGHkaqsdyeR3fpoVt405u42fL+D02SLOxdUNxdBvXZrG+YvscWexg7vo/XLQfqBPPd+p1uI0KCAvMLRPTQCL8PUUM9cTKgllF4yanBYdhEsixekR8yKXyGK7xKi9FKCFGIhEeLfQAkoF5UrGwfgvZVuX0QfoJu+fwVoEpKAYJX6F2WGTTFT0eKZFquiMKEe187uV3NZCfRvDsp4ljTTrMgVYLzzh5wOUCy28ylex3huYvhslxzQqzNscT4D9sEZxJ9q1wQLlVmWI/dmJbSRJIf3MtP4nv9q9egthUVKZ/8/ouexdmM=

tyr sshkey orthrus:
  ssh_auth.present:
    - user: tyr
    - enc: ssh-ed25519
    - comment: tyr@Orthrus
    - name: AAAAC3NzaC1lZDI1NTE5AAAAIFuDWtFaKvDW1xsWJ8q9/Zc7xCDTaUqb9EJRD8NOD4vP
