{% from "service/rabbitmq/map.jinja" import rabbitmq with context -%}
rabbitmq_repo:
  file.managed:
    - name: /root/software/rabbitmq-server-3.0.2.tar.gz
    - source: salt://service/rabbitmq/file/rabbitmq-server-3.0.2.tar.gz
    - makedirs: True

erlang_install:
  pkg.installed:
    - pkgs:
      - erlang

rabbitmq_install:
  cmd.run:
    - names:
      - cd /root/software/ && tar xf rabbitmq-server-3.0.2.tar.gz && cd rabbitmq-server-3.0.2 && make && make install TARGET_DIR={{ rabbitmq.target_dir }} SBIN_DIR={{ rabbitmq.sbin_dir }} MAN_DIR={{ rabbitmq.man_dir }}

test:
  cmd.run:
    - names:
      - curl -k -L http://localhost:15672
    - require:
      - pkg: erlang_install
      - cmd: rabbitmq_install
