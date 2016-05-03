#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

#chown the lazylibrarian directory by the new user
chown mediadepot:mediadepot -R /srv/lazylibrarian

# download the latest version of LazyLibrarian
[[ ! -d /srv/lazylibrarian/app/.git ]] && su -c "git clone https://github.com/DobyTang/LazyLibrarian.git /srv/lazylibrarian/app" mediadepot

# opt out for autoupdates using env variable
if [ -z "$ADVANCED_DISABLEUPDATES" ]; then
	# update the application
	cd /srv/lazylibrarian/app/ && su -c "git pull" mediadepot
fi

# run LazyLibrarian
su -c "/usr/bin/python /srv/lazylibrarian/app/LazyLibrarian.py --nolaunch --datadir=/srv/lazylibrarian/data --config=/srv/lazylibrarian/config/lazylibrarian.ini" mediadepot
