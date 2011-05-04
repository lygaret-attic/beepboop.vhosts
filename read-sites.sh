#!/bin/bash

vhosts=`find $1 -mindepth 1 -maxdepth 1 \
	\( -type d -or -type l \) \
	-exec test -e "{}/server.conf" \; \
	-exec basename "{}" \; 2>/dev/null`

for VHOST in $vhosts
do {
	echo "\$HTTP[\"host\"] =~ \"^(www\.|)$VHOST\" {"
	echo "    var.vhost_name = \"$VHOST\""
	echo "    var.vhost_path = \"$1/$VHOST\""
	echo ""
	echo "    server.document-root = \"$1/$VHOST/public\""
	echo "    server.errorfile-prefix = \"$1/$VHOST/errors/status-\""
	echo "    server.errorlog = \"$1/$VHOST/log/error.log\""
	echo "    accesslog.filename = \"$1/$VHOST/log/access.log\""
	echo ""
	cat "$1/$VHOST/server.conf"
	echo "}"
}
done
