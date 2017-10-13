#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/root/bin
export PATH
srvIP="192.168.1.13"
ftpUser="xml"
ftpPwd="Y0urFtpP@ssw)rd"
zbxPkg="zabbix-3.0.4.tar.gz"
#ftpPath="ftp://$srvIP/$zbxPkg"
srcPath="/usr/local/src"
installPath="/usr/local/zabbix"
zbxConf="/usr/local/zabbix/etc/zabbix_agentd.conf"
serviceFile=/etc/init.d/zabbix_agentd
serviceCfg=/usr/local/zabbix/etc/zabbix_agentd.conf
mv /tmp/$zbxPkg /$srcPath
cd $srcPath
#wget --user=$ftpUser --password=$ftpPwd $ftpPath
HOSTNAME=$(hostname)

#add zabbix user
if [ `cat /etc/passwd|grep 'zabbix' |wc -l` -eq 0 ];then
        groupadd -r zabbix
        useradd -g zabbix -s /sbin/nologin -r zabbix
fi
yum install -y gcc gcc++
tar zxf $zbxPkg

cd zabbix-3.0.4
./configure --prefix=$installPath  --enable-agent

if [ $? -eq 0 ];then
      make install
fi

cp $srcPath/zabbix-3.0.4/misc/init.d/tru64/zabbix_agentd /etc/init.d/
sed -i "s%BASEDIR=/usr/local%BASEDIR=$installPath" $serviceFile 
sed -i "s%Hostname=Zabbix server%#Hostname=Zabbix server%" $serviceCfg 
chmod +x /etc/init.d/zabbix_*
#chkconfig --add zabbix_agentd
#chkconfig zabbix_agentd on
sed -i 's/Server=127.0.0.1/Server='$srvIP'/' $zbxConf
sed -i 's/ServerActive=127.0.0.1/ServerActive='$srvIP'/' $zbxConf
sed -i 's/Hostname=Zabbix server/Hostname='$HOSTNAME'/' $zbxConf
#/etc/init.d/zabbix_agentd start

#if [ `cat /etc/rc.d/rc.local|grep 'zabbix_agentd' |wc -l` -eq 0 ];then
#  sed -i '$a /usr/local/zabbix/sbin/zabbix_agentd &' /etc/rc.d/rc.local
#fi

