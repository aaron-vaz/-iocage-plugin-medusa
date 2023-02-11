#!/bin/sh

echo "Create location for medusa"
mkdir -p /usr/local/medusa

echo "Download medusa repo"
git clone https://github.com/pymedusa/Medusa.git /usr/local/medusa

echo "Create medusa user"
pw user add medusa -c "medusa" -d /nonexistent -s /usr/bin/nologin -w no
chown -R medusa:medusa /usr/local/medusa

echo "Installing medusa service"
mkdir -p /usr/local/etc/rc.d
cp /usr/local/medusa/runscripts/init.freebsd /usr/local/etc/rc.d/medusa

echo "Executing medusa service"
chmod u+x /usr/local/etc/rc.d/medusa
sysrc medusa_enable="YES"
sysrc medusa_python_dir="/usr/local/bin/python3"
service medusa start