apt-get update
apt-get install -y python-software-properties python g++ make git
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

npm install -g grunt grunt-cli bower

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get install -y mongodb-10gen

su vagrant -c "cd ~; git clone http://github.com/nwoodbury/tdf.git"
su vagrant -c "cd ~/tdf; npm install"
crontab tickercron3000

NODE_ENV=production PORT=3000 /home/vagrant/tdf/node_modules/pm2/bin/pm2 start server.js -i max

cat >/etc/init/tdf-pm2-web.conf <<EOF
description "Tour De Finance - Web Monitor"
author      "IDeA Labs 2014"

start on started mountall
stop on shutdown

respawn
respawn limit 99 5

setuid vagrant

script
    exec /home/vagrant/tdf/node_modules/pm2-web/bin/pm2-web.sh
end script
EOF

start tdf-pm2-web
