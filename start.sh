#!/usr/bin/env bash
if [ ! -f /srv/lazylibrarian/config/lazylibrarian.ini ]; then

	confd -onetime -backend rancher -prefix /2015-07-25
	chown -R depot:depot /srv/lazylibrarian
fi

su -c "/usr/bin/python /srv/lazylibrarian/app/LazyLibrarian.py --nolaunch --datadir=/srv/lazylibrarian/data --config=/srv/lazylibrarian/config/lazylibrarian.ini" depot
