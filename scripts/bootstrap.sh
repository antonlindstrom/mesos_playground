#!/usr/bin/env bash

# Run SE Mirror
sed -i 's/\/\/us./\/\/se./' /etc/apt/sources.list

# Docker repo
#apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

# Update
apt-get update -y

# Install prereqs
apt-get install -y zookeeperd default-jre python-setuptools python-protobuf curl

# Docker
apt-get install -y lxc-docker

if [ ! -d /tmp/pkg ]; then
  mkdir /tmp/pkg
fi

# Install Mesos
if [ ! -f /tmp/pkg/mesos.deb ]; then
  wget -O /tmp/pkg/mesos.deb http://downloads.mesosphere.io/master/ubuntu/12.04/mesos_0.18.0-rc2_amd64.deb
fi

dpkg -i /tmp/pkg/mesos.deb

## Install Marathon
if [ ! -f /tmp/pkg/marathon.tgz ]; then
  wget -O /tmp/pkg/marathon.tgz http://downloads.mesosphere.io/marathon/marathon-0.4.0.tgz
fi

tar xzf /tmp/pkg/marathon.tgz -C /opt
wget -O /etc/init/marathon.conf https://gist.githubusercontent.com/antonlindstrom/a80fe9c3369a73954ecd/raw/marathon.conf

# Mesos-Docker
mkdir -p /var/lib/mesos/executors
wget -O /var/lib/mesos/executors/docker https://raw.github.com/mesosphere/mesos-docker/master/bin/mesos-docker

# Mesos python egg
if [ ! -f /tmp/pkg/mesos.egg ]; then
  wget -O /tmp/pkg/mesos.egg http://downloads.mesosphere.io/master/ubuntu/12.04/mesos_0.18.0-rc2_amd64.egg
fi

easy_install /tmp/pkg/mesos.egg

# Start Mesos
start mesos-master
start mesos-slave

# Start Marathon
start marathon
