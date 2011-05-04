#!/bin/sh

basedir=/srv/http/sites
sitedir=/srv/http/sites/$1

cd $basedir
tar -xvf /srv/http/mksite_template.tar > /dev/null
mv $basedir/_newsite $sitedir
sudo chown -R http:http $sitedir

echo "$sitedir created..." 
echo "  The server must be restarted to pick up the virtual host name..."
echo "  Do this now? [y/N] (will ask for password, work as sudo):"
read answer

if [ "$answer" = "y" ]; then
 sudo /etc/rc.d/lighttpd restart
fi
