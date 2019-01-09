{%- from 'service/redis/map.jinja' import redis with context -%}
redis_repo:
  file.managed:
    - name: /root/software/redis-2.8.8.tar.gz
    - source: salt://service/redis/file/redis-2.8.8.tar.gz
    - makedirs: True

redis_install:
  cmd.run:
    - names:
      - cd /root/software/ && tar xvzf redis-2.8.8.tar.gz && cd redis-2.8.8 && make && make PREFIX={{ redis.base_dir }} install
    - require:
      - file: redis_repo

redis_conf:
  cmd.run:
    - names:
      - mkdir -p /data/conf/redis
      - mkdir -p /data/logs/redis
      - mkdir -p /data/redis
    - unless:
      - test -d /data/conf/redis
      - test -d /data/logs/redis
      - test -d /data/redis
  file.managed:
    - name: /data/conf/redis/redis-{{ redis.port }}.conf
    - source: salt://service/redis/file/redis-{{ redis.port }}.conf
    - makedirs: True

redis_service:
  file.managed:
    - name: /etc/init.d/redis_{{ redis.port }}
    - source: salt://service/redis/file/redis_{{ redis.port }}
    - mode: 755
    - makedirs: True
    - template: jinja

redis_chkconfig:
  cmd.run:
    - names:
      - chkconfig --add redis_{{ redis.port }}
      - chkconfig redis_{{ redis.port }} on
    - require:
      - file: redis_service

redis_running:
  cmd.run:
    - names:
      - /etc/init.d/redis_{{ redis.port }} start
    - watch:
      - file: redis_conf
    - require:
      - cmd: redis_chkconfig
