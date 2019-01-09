{% from "service/php7/map.jinja" import php with context -%}
php_repo:
  file.managed:
    - name: /root/software/{{ php.php_version }}.tar.gz
    - source: salt://service/php7/file/{{ php.php_version }}.tar.gz
    - makedirs: True

php_install:
  cmd.run:
    - names:
      - mkdir -p {{ php.pid_dir }}
      - chmod 777 {{ php.pid_dir }}
      - mkdir -p {{ php.conf_dir }}
      - mkdir -p {{ php.log_dir }}
      - cd /root/software/ && tar -xf /root/software/{{ php.php_version }}.tar.gz && cd /root/software/{{ php.php_version }} && ./configure --prefix={{ php.php_basedir }} --sysconfdir={{ php.conf_dir }} --with-config-file-path={{ php.conf_dir }} --enable-mysqlnd --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-iconv --with-freetype-dir --with-jpeg-dir --with-png-dir --enable-zip --with-zlib --with-bz2 --enable-calendar --enable-exif --with-libxml-dir --enable-xml --disable-rpath --disable-short-tags --enable-bcmath --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-soap --enable-intl --with-pdo-pgsql --enable-fpm && make -j8 && make install && cd /root/software/ && wget http://pecl.php.net/get/imagick-3.4.3.tgz && tar xf imagick-3.4.3.tgz && cd imagick-3.4.3 && /usr/local/php7/bin/phpize && ./configure --with-php-config={{ php.php_basedir }}/bin/php-config && make && make install && cd /root/software/ && wget http://pecl.php.net/get/redis-3.1.2.tgz && tar xf redis-3.1.2.tgz && cd redis-3.1.2 && /usr/local/php7/bin/phpize && ./configure --with-php-config={{ php.php_basedir }}/bin/php-config && make && make install && cd /root/software/{{ php.php_version }}/ext/pgsql && {{ php.php_basedir }}/bin/phpize && ./configure --with-php-config={{ php.php_basedir }}/bin/php-config && make && make install && ln -sv {{ php.php_basedir }} /usr/local/php
    - require:
      - file: php_repo
