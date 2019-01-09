Deveploer_tools:
  cmd.run:
    - names:
#      - yum -y update
      - yum -y groupinstall "Development tools"

Basic_environment:
  pkg.installed:
    - pkgs:
#运维工具
      - screen
      - nfs-utils
      - lrzsz
      - wget
      - iproute
      - iotop
      - mtr
      - perf
      - telnet
      - dstat
      - iftop
      - vim
      - tree
      - lsof
#Nginx.PHP
      - libxml2
      - libxml2-devel
      - openssl-devel
      - bzip2
      - bzip2-devel
      - libcurl-devel
      - libjpeg
      - libjpeg-devel
      - libpng-devel
      - libicu-devel
      - libmcrypt-devel
      - freetype-devel
      - libtidy
      - libtidy-devel
      - ImageMagick-devel
      - mhash
      - mhash-devel
      - pcre-devel
#MySQL
      - gcc
      - gcc-c++
      - libgcrypt
      - openssl098e
      - ncurses
      - ncurses-devel
      - make
      - cmake
      - bison
      - ncurses-libs
      - libaio
      - unzip
      - readline-devel
      - perl-Module-Install.noarch
#RabbitMQ
      - xmlto
      - unixODBC
      - unixODBC-devel
      - autoconf
      - glibc-devel
      - libxslt
#gcc、gcc-c++、glibc
      - gd-devel
#Postgre
      - perl-ExtUtils-Embed
      - zlib-devel
      - python-devel 
    - require:
      - cmd: Deveploer_tools
