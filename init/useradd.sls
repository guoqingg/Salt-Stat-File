{%- from "init/map.jinja" import init with context -%}
{%- for users in init.user_list %}
add_{{users}}:
  user.present:
    - name: {{ users }}
    - shell: /bin/bash
    - gid: 500
    - require:
      - group: developer

add_{{users}}.ssh:
  file.directory:
    - name: /home/{{ users }}/.ssh/
    - user: {{ users }}
    - group: developer
    - mode: 700
    - makedirs: True
    - require:
      - user: add_{{users}}

add_{{users}}_authfile:
  file.managed:
    - name: /home/{{ users }}/.ssh/authorized_keys
    - user: {{ users }}
    - group: developer
    - mode: 600
    - source: salt://init/file/authfile/{{ users }}/authorized_keys
    - require:
      - file: add_{{users}}.ssh
{% endfor %}

developer:
  group.present:
    - name: developer
    - gid: 500

sudoers:
  file.managed:
    - name: /etc/sudoers
    - source: salt://init/file/sudoers
    - mode: 440
    - user: root
    - group: root
