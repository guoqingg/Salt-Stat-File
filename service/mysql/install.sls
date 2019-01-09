mysql_repo:
  file.managed:
    - name: /root/software/percona-server-5.6.29-76.2.tar.gz
    - source: salt://service/mysql/file/percona-server-5.6.29-76.2.tar.gz
    - makedirs: True

mysql_group:
  group.present:
    - name: mysql
    - gid: 306

mysql_user:
  user.present:
    - name: mysql
    - shell: /sbin/nologin
    - gid: 306
    - require:
      - group: mysql_group

mysql_install:
  cmd.run:
    - names:
      - mkdir -p /root/software
      - mkdir -p /data/conf/mysql
      - mkdir -p /data/mysql/tmp
      - chown mysql.mysql /data/mysql -R
      - cd /root/software && tar xf percona-server-5.6.29-76.2.tar.gz && cd percona-server-5.6.29-76.2 && cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc/my.cnf -DMYSQL_TCP_PORT=3306 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DENABLE_DTRACE=0 -DWITH_EXTRA_CHARSETS=all && make -j8 && make install && /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/data/mysql --basedir=/usr/local/mysql && echo "export PATH=\$PATH:/usr/local/mysql/bin" > /etc/profile.d/mysql.sh && source /etc/profile.d/mysql.sh
    - require:
      - user: mysql_user

/data/conf/mysql/my.cnf:
  file.managed:
    - name: /data/conf/mysql/my.cnf
    - source: salt://service/mysql/file/my.cnf
    - mode: 755
    - template: jinja

  cmd.run:
    - names:
      - rm -f /etc/my.cnf
      - ln -s /data/conf/mysql/my.cnf /etc/my.cnf
    - watch:
      - file: /data/conf/mysql/my.cnf

/etc/init.d/mysql:
  file.managed:
    - name: /etc/init.d/mysql
    - source: salt://service/mysql/file/mysql
    - mode: 755

chkconfig:
  cmd.run:
    - names:
      - chkconfig --add mysql
      - chkconfig mysql on
    - require:
      - file: /etc/init.d/mysql

mysql:
  service.running:
    - reload: True
    - enable: True
    - watch:
      - file: /data/conf/mysql/my.cnf
    - require:
      - cmd: chkconfig
