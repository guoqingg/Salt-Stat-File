#!/bin/bash
cd /root/software && tar xf gcc-5.2.0.tar.gz && cd gcc-5.2.0 && ./contrib/download_prerequisites && mkdir build && cd build && ../configure --enable-checking=release --enable-languages=c,c++ --enable-threads=posix --disable-multilib && make -j8 && yum remove -y gcc && make install && echo "export PATH=/usr/local/bin:$PATH" >> /etc/profile

