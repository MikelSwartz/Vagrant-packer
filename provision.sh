#!/usr/bin/env bash

PACKER_VERSION="0.8.6" 
URL="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"

yum install net-tools telnet wget vim unzip -y

echo 127.0.0.1   localhost.localhost localhost > /etc/hosts
echo 10.0.15.200 mgt01.packer      mgt01 >> /etc/hosts

systemctl disable firewalld
systemctl stop firewalld

sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config


sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
/bin/systemctl restart  sshd.service
chmod +w /etc/sudoers
sed -i 's/^\%wheel.*/##%wheel ALL=(ALL)       ALL/g' /etc/sudoers
sed -i 's/^# \%wheel.*/%wheel  ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers
chmod -w /etc/sudoers

cd /vagrant/
if [ -s packer_1.0.4_linux_amd64.zip ] ; then
  echo packer_1.0.4_linux_amd64.zip already downloaded.
else
  wget -O  packer_${PACKER_VERSION}_linux_amd64.zip $URL
fi

unzip packer_${PACKER_VERSION}_linux_amd64.zip
rm /vagrant/packer_${PACKER_VERSION}_linux_amd64.zip

sed -i -e 's/NM_CONTROLLED=no/NM_CONTROLLED=yes/' /etc/sysconfig/network-scripts/ifcfg-eth1 #Some versions of VBox do not set this correctly and the ifcfg does not start on boot
reboot
