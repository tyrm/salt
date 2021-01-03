---
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
