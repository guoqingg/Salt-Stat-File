{%- from "init/map.jinja" import init with context -%}

history_logrotate_package:
  pkg.installed:
    - name: {{ init.logrotate_package }}

history_log_logrotate_conf_directory:
  file.directory:
    - name: {{ init.logrotate_conf_directory }}
    - require:
      - pkg: history_logrotate_package

history_log_logrotate_conf_file:
  file.managed:
    - name: {{ init.logrotate_conf_directory }}/{{ init.logrotate_conf_file }}
    - source: salt://init/file/logrotate
    - template: jinja
    - require:
      - pkg: history_logrotate_package
      - file: history_log_logrotate_conf_directory

