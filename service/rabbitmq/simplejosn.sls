simplejosn_repo:
  file.managed:
    - name: /root/software/simplejson-3.10.0.tar.gz
    - source: salt://service/rabbitmq/file/simplejson-3.10.0.tar.gz
    - makedirs: True

simplejosn_install:
  cmd.run:
    - names:
      - cd /root/software && tar xf simplejson-3.10.0.tar.gz && cd simplejson-3.10.0 && python setup.py build && python setup.py install
    - require:
      - file: simplejosn_repo
