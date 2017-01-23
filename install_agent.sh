#!/bin/bash
sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo sysctl -p

## Checking CentOS version for rpm file
version=`sudo cat /etc/redhat-release | awk '{ print $4 }' | cut -d . -f 1`
if [ $version == "7" ]
then
	sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
else
	sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
fi

sudo yum install -y puppet

sudo echo "%vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
