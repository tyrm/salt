---
# CA Scripts
/var/lib/asterisk/ca-scripts:
  file.directory:
    - user: asterisk
    - group: asterisk
    - dir_mode: 750
    - require:
      - pkg: asterisk

{% set scripts = [
  'gen_csr.sh',
  'gen_key.sh',
  'gen_root_cert.sh',
  'gen_root_key.sh',
  'show_cert.sh',
  'show_root_cert.sh',
  'sign_csr.sh'
] %}
{% for script in scripts %}
/var/lib/asterisk/ca-scripts/{{script}}:
  file.managed:
    - group: asterisk
    - mode: 750
    - source: salt://profiles/asterisk/ca/files/scripts/{{script}}
    - user: asterisk
    - require:
      - file: /var/lib/asterisk/ca-scripts
{% endfor %}

# CA Infrastructure
/etc/asterisk/ca:
    file.directory:
      - group: asterisk
      - user: asterisk
      - mode: 750
      - require:
        - pkg: asterisk

{% set folders = ['certs', 'confs', 'csr', 'newcerts'] %}
{% for folder in folders %}
/etc/asterisk/ca/{{folder}}:
    file.directory:
      - group: asterisk
      - user: asterisk
      - mode: 750
      - require:
        - file: /etc/asterisk/ca
{% endfor %}

/etc/asterisk/ca/private:
    file.directory:
      - group: asterisk
      - user: asterisk
      - mode: 700
      - require:
        - file: /etc/asterisk/ca

/etc/asterisk/ca/index.txt:
    file.managed:
      - group: asterisk
      - user: asterisk
      - mode: 640
      - require:
        - file: /etc/asterisk/ca

echo 1000 > /etc/asterisk/ca/serial:
  cmd.run:
    - creates: /etc/asterisk/ca/serial
    - require:
      - file: /etc/asterisk/ca

/etc/asterisk/ca/serial:
    file.managed:
      - group: asterisk
      - user: asterisk
      - mode: 640
      - require:
        - cmd: echo 1000 > /etc/asterisk/ca/serial

/etc/asterisk/ca/openssl.cnf:
  file.managed:
    - group: asterisk
    - mode: 644
    - source: salt://profiles/asterisk/ca/files/ca-openssl.cnf.j2
    - template: jinja
    - user: asterisk
    - require:
      - file: /etc/asterisk/ca

# Server cert
/etc/asterisk/ca/confs/server.cnf:
  file.managed:
    - group: asterisk
    - mode: 644
    - source: salt://profiles/asterisk/ca/files/server-openssl.cnf.j2
    - template: jinja
    - user: asterisk
    - require:
      - file: /etc/asterisk/ca/confs

# Client certs
{% for ext, conf in salt['pillar.get']('asterisk:users', {}).items() %}
/etc/asterisk/ca/confs/{{conf['user']}}.cnf:
  file.managed:
    - group: asterisk
    - mode: 644
    - source: salt://profiles/asterisk/ca/files/client-openssl.cnf.j2
    - template: jinja
    - user: asterisk
    - defaults:
        common_name: conf['user']
    - require:
      - file: /etc/asterisk/ca/confs
{%- endfor %}
