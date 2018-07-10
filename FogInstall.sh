#!/bin/bash
echo UPDATING ENVIROMENT
echo ----------------------------------------------------------------
sudo yum update -y
echo ...
echo INSTALLING REQUIRED TOOLS
echo ----------------------------------------------------------------
wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-server-8.0.11-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-server-8.0.11-1.el7.x86_64.rpm
sudo yum install -y tigervnc-server hicolor-icon-theme sed bc curl gcc gcc-c++ genisoimage gettext gzip httpd lftp m4 make mod_ssl mtools mysql mysql-server net-tools nfs-utils php php-bcmath php-cli php-common php-fpm php-gd php-ldap php-mbstring php-mcrypt php-mysqlnd php-process syslinux tar tftp-server unzip vsftpd wget xinetd xz-devel git
sudo yum -y groups "GNOME Desktop"
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/gnome-icon-theme-3.12.0-1.el7.noarch.rpm
sudo rpm -ivh gnome-icon-theme-3.12.0-1.el7.noarch.rpm
echo ...
echo SETTING UP TOOLS
echo ----------------------------------------------------------------
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo sed -i.bak 's/^.*\SELINUX=enforcing\b.*$/SELINUX=permissive/' /etc/selinux/config
sudo setenforce 0
sudo cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:5.service
sudo sed -i 's/<USER>/i2a2-user/g' /etc/systemd/system/vncserver@:5.service
vncserver
sudo systemctl daemon-reload
sudo systemctl start vncserver@:5.service
sudo systemctl enable vncserver@:5.service
echo ...
echo INSTALLING FOG PROJECT
echo ----------------------------------------------------------------
cd ~
mkdir git
cd git
git clone https://github.com/FOGProject/fogproject.git
cd fogproject/bin
./installfog.sh
echo "Now you should have fog installed."