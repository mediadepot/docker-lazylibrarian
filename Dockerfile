FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Create internal depot user (which will be mapped to external DEPOT_USER, with the uid and gid values)
RUN groupadd -g 15000 -r depot && useradd --uid 15000 -r -g depot depot

#Install base applications + deps
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" | tee -a /etc/apt/sources.list
RUN apt-get -q update && \
    apt-get install -qy --force-yes python-cheetah unrar git curl && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create confd folder structure
RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
RUN chmod u+x  /usr/local/bin/confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

#Create lazylibrarian folder structure & set as volumes
RUN mkdir -p /srv/lazylibrarian/app && \
	mkdir -p /srv/lazylibrarian/config && \
	mkdir -p /srv/lazylibrarian/data


#Install LazyLibrarian
RUN git clone https://github.com/DobyTang/LazyLibrarian/ /srv/lazylibrarian/app

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/lazylibrarian/app", "/srv/lazylibrarian/config", "/srv/lazylibrarian/data"]

EXPOSE 8080

CMD ["bash"]
#CMD ["/srv/start.sh"]