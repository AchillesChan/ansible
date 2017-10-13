#!/bin/bash
export
PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/zhang/bin
yum -y install ncurses-devel gcc gcc++ autoconf automake
/bin/mkdir -p /usr/local/screen
/bin/tar zxf /tmp/screen.tar.gz -C /usr/local/screen
cd /usr/local/screen/v.4.3.1/src
./autogen.sh
./configure --with-sys-screenrc=/etc/screenrc && \
        sed -i -e "s%/usr/local/etc/screenrc%/etc/screenrc%" {etc,doc}/* && \
        make    
rm /usr/bin/screen -f
ln -s /usr/local/screen/v.4.3.1/src/screen /usr/bin/screen
