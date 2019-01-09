/etc/init.d/rabbitmq:
  file.managed:
    - source: salt://service/rabbitmq/file/rabbitmq
    - mode: 755

chkconfig:
  cmd.run:
    - names:
      - chkconfig --add rabbitmq
      - chkconfig rabbitmq on
    - require:
      - file: /etc/init.d/rabbitmq
