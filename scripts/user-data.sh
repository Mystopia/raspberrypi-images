#!/usr/bin/env bash
set -e
set -x

export DEBIAN_FRONTEND=noninteractive

echo "Install Adafruit Occidentalis"
INSTALL_OCCIDENTALIS=1
if [ $INSTALL_OCCIDENTALIS -eq 1 ]; then
  curl -SLs https://apt.adafruit.com/install | sudo bash
  OCCIDENTALIS=/boot/occidentalis.txt
  if [ ! -f $OCCIDENTALIS ]; then
    cp /usr/share/doc/occi/occidentalis_example.txt /boot/occidentalis.txt
    echo "File ${OCCIDENTALIS} was created… edit it as needed"
  else
    echo "File ${OCCIDENTALIS} already exists… skipping"
  fi
else
  echo "INSTALL_OCCIDENTALIS (${INSTALL_OCCIDENTALIS}) is not set… skipping"
fi

echo "Update and Upgrade"
FULL_UPGRADE=1
if [ $FULL_UPGRADE -eq 1 ]; then
  apt update && apt upgrade -y
else
  echo "FULL_UPGRADE (${FULL_UPGRADE}) is not set… skipping"
fi

echo "Install extras"
INSTALL_EXTRAS=1
if [ $INSTALL_EXTRAS -eq 1 ]; then
  apt install -y htop
  apt install -y supervisor
  # apt install -y tmux
else
  echo "INSTALL_EXTRAS (${INSTALL_EXTRAS}) is not set… skipping"
fi

echo "All done!"
