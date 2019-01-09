{% from "service/postgre/map.jinja" import pg with context -%}
pg_repo:
  file.managed:
    - name: /root/software/{{ pg.pg_version }}.tar.gz
    - source: salt://service/postgre/file/{{ pg.pg_version }}.tar.gz
    - makedirs: True

pg_install:
  cmd.run:
    - names:
      - cd /root/software/ && tar xf {{ pg.pg_version }}.tar.gz && cd {{ pg.pg_version }} && ./configure --prefix={{ pg.pg_basedir }} --with-perl --with-python && make -j8 && make install
      - echo "export PATH=$PATH:/usr/local/pgsql/bin" >> /etc/profile
      - echo "export PGDATA=/data/pgsql" >> /etc/profile
      - source /etc/profile
      - echo "/usr/local/pgsql/lib" >> /etc/ld.so.conf.d/pgsql.conf && ldconfig
