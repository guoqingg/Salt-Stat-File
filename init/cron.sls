ntp_cron:
  cron.present:
    - name: /usr/sbin/ntpdate cn.pool.ntp.org > /dev/null 2>&1 && /sbin/clock -w
    - user: root
    - minute: 20

