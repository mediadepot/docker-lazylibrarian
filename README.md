# Requirements


# Environmental
The following environmental variables must be populated, when running container 

- PUID
- PGID

# Ports
The following ports must be mapped, when running container 

 - 5299 #webui listen 
 
# Volumes
The following volumes must be mapped, when running container 

- /srv/lazylibrarian/config
- /srv/lazylibrarian/data
- /mnt/ebooks:/mnt/ebooks
- /mnt/downloads/[Tvshows]:/mnt/downloads
- /mnt/blackhole/[Tvshows]:/mnt/blackhole
