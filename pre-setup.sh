#!/bin/bash

#Disable firewall
systemctl disable firewalld
systemctl stop firewalld

modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
echo '1' > /proc/sys/net/ipv4/ip_forward

#Turn off selinux
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/sysconfig/selinux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

#Disable swap
swapoff -a
sed -i "s/.*swap.*/#&/" /etc/fstab

#Modify k8s.conf
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

#reload configuration file
sysctl --system

# Setup the Kubernetes Repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

#clean
yum clean all -y && yum makecache -y && yum repolist -y

[root@ansible ~]# chmod a+x pre-setup.sh