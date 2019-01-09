{%- from "init/map.jinja" import init with context -%}

history_conf_directory:
  file.directory:
    - name: {{ init.logrotate_conf_directory }}

history_conf_file:
  file.managed:
    - name: /etc/profile.d/{{ init.conf_file }}
    - source: salt://init/file/conf.sh
    - template: jinja

source_conf_file:
  cmd.run:
    - names:
      - source /etc/profile.d/{{ init.conf_file }}
    - require:
      - file: history_conf_file

{%- for script in init.scripts_list %}
history_scripts_file_{{ script }}:
  file.managed:
    - name: {{ script }}
    - source: salt://init/file/scripts_file
    - mode: 755
    - template: jinja
    - require:
      - file: history_conf_file
{%- endfor %}

history_log_directory:
  file.directory:
    - name: {{ init.log_directory }}
    - mode: 755
    - require:
      - file: history_conf_file

history_log_file:
  file.managed:
    - name: {{ init.log_directory }}/{{ init.log_file }}
    - user: root
    - group: root
    - mode: 002
    - require: 
      - file: history_log_directory

{% if init.logrotate %}

include:
  - init.logrotate

{%- endif -%}

