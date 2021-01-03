[transport-udp]
type=transport
protocol=udp
bind=0.0.0.0

;Templates for the necessary config sections

[endpoint_internal](!)
type=endpoint
context=from-internal
disallow=all
allow=ulaw

[auth_userpass](!)
type=auth
auth_type=userpass

[aor_dynamic](!)
type=aor
max_contacts=1

;Definitions for our phones, using the templates above

{%- for key, conf in salt['pillar.get']('asterisk:users', {}).items() %}
[{{conf['user']}}](endpoint_internal)
auth={{conf['user']}}
aors={{conf['user']}}
[{{conf['user']}}](auth_userpass)
password={{conf['pass']}}
username={{conf['user']}}
[{{conf['user']}}](aor_dynamic)
{% endfor -%}
