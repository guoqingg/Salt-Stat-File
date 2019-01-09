gcc_packge:
  file.managed:
    - source: salt://system/file/gcc-5.2.0.tar.gz
    - name: /root/software/gcc-5.2.0.tar.gz
    - user: root
    - group: root
    - makedirs: True
    - mode: 644

gcc_install.sh:
  file.managed:
    - source: salt://system/file/gcc_install.sh
    - name: /usr/local/service/tools/gcc_install.sh
    - user: root
    - group: root
    - makedirs: True
    - mode: 777
    - require:
      - file: gcc_packge

gcc_install:
  cmd.run:
    - names:
      - /bin/bash /usr/local/service/tools/gcc_install.sh &>/dev/null &
    - require:
      - file: gcc_install.sh
