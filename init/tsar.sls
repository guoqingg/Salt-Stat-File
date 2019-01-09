tsar:
  file.managed:
    - source: salt://init/file/tsar-master.zip
    - name: /root/software/tsar-master.zip
    - makedirs: True
    - user: root
    - group: root
    - mode: 644

install:
  cmd.run:
    - names:
      - cd /root/software/ && unzip tsar-master.zip && cd tsar-master && make && make install

/etc/tsar/tsar.conf:
  file.managed:
    - source: salt://init/file/tsar.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: tsar

