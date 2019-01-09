{% from "service/php7/map.jinja" import php with context -%}
include:
  - service.php7.install

php-fpm:
  file.managed:
    - name: {{ php.conf_file }}
    - source: salt://service/php7/file/php-fpm.conf
    - mode: 644

php-ini:
  file.managed:
    - name: {{ php.ini_file }}
    - source: salt://service/php7/file/php.ini
    - mode: 644

php-service:
  file.managed:
    - name: {{ php.service_file }}
    - source: salt://service/php7/file/php7-fpm
    - template: jinja
    - mode: 755

  cmd.run:
    - names:
      - /sbin/chkconfig --add php7-fpm
      - /sbin/chkconfig php7-fpm on
    - unless: /sbin/chkconfig --list |grep php7-fpm

  service.running:
    - name: php7-fpm
    - enable: True
    - require:
      - cmd: php-service
    - watch:
      - file: php-ini
      - file: php-fpm
