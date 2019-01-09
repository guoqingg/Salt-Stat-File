zabbix_repo:
  cmd.run:
    - names:
      - rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/{{ grains['osmajorrelease'] }}/{{ grains['osarch'] }}/zabbix-release-3.4-1.el{{ grains['osmajorrelease'] }}.centos.noarch.rpm  

zabbix-agent:
  pkg.installed:
    - pkgs:
      - zabbix-agent
      - zabbix-sender
    - require:
      - cmd: zabbix_repo

/usr/local/bin/lld-disks.py:
  file.managed:
    - source: salt://init/file/zabbix/lld-disks.py
    - user: root
    - group: root
    - mode: 755

/etc/zabbix/zabbix_agentd.d/userparameter_diskstats.conf:
  file.managed:
    - source: salt://init/file/zabbix/userparameter_diskstats.conf
    - user: root
    - group: root
    - mode: 644

/usr/local/bin/tcp_conn.sh:
  file.managed:
    - source: salt://init/file/zabbix/tcp_conn.sh
    - user: root
    - group: root
    - mode: 755

/etc/zabbix/zabbix_agentd.d/userparameter_tcp.conf:
  file.managed:
    - source: salt://init/file/zabbix/userparameter_tcp.conf
    - user: root
    - group: root
    - mode: 644

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://init/file/zabbix/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

  service.running:
    - reload: True
    - enable: True
    - name: zabbix-agent
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf
