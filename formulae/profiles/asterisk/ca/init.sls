---
// Scripts to help Drew
/var/lib/asterisk/ca-scripts:
  file.directory:
    - user: asterisk
    - group: asterisk
    - dir_mode: 750
    - require:
      - pkg: asterisk

{% set scripts = ['certs', 'crl', 'newcerts'] %}
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

// CA Infrastructure
/etc/asterisk/ca:
    file.directory:
      - group: asterisk
      - user: asterisk
      - mode: 750
      - require:
        - pkg: asterisk

{% set folders = ['certs', 'crl', 'newcerts'] %}
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
    - source: salt://profiles/asterisk/ca/files/ca-openssl.cnf
    - user: asterisk
    - require:
      - file: /etc/asterisk/ca
