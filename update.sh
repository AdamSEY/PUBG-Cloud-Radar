#!/bin/bash
echo "Welcome to use one-click build"
echo "The upcoming version is 4.30, local map version"
echo "Ready to start installation"
read -p "Start the installation after the carriage return"
echo "Please enter your internet ip"
read -p "ip： " ip
cp /root/PUBG-Cloud-Radar/restart.sh /root/restart.sh
chmod +x restart.sh
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log

echo "ss build, please remember the connection information"
read -p "done? Any key to continue"

curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
source ~/.bash_profile
nvm install v9.8.0
nvm alias default v9.8.0
yum -y install gcc-c++
yum -y install flex
yum -y install bison
yum -y install wget
wget http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz
tar -zxvf libpcap-1.8.1.tar.gz
cd libpcap-1.8.1
./configure
make
make install

cd /root
cd PUBG-Cloud-Radar/
npm i
npm i -g pino
npm install -g forever
npm install -g pino-pretty
forever start index.js sniff eth0 $ip | pino-pretty

echo "搭建完成"
