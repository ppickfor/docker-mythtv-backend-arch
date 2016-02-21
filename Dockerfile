#use snapshot repo
FROM pritunl/archlinux:latest
MAINTAINER Peter Pickford <docker@netremedies.ca>

#RUN pacman -Sy archlinux-keyring --noconfirm && pacman -Sy filesystem pacman --noconfirm && pacman-db-upgrade && pacman -Syu --noconfirm && pacman-db-upgrade && pacman -S znc cyrus-sasl supervisor --noconfirm
RUN pacman -Syu mythtv apache php-apache php mythplugins-mythweb icu supervisor xorg-xauth --noconfirm
EXPOSE 80 6543 6544
ADD ./add/timezone /etc/timezone
ADD ./add/mythweb.conf /etc/apache2/sites-available/mythweb.conf
ADD ./add/config.xml /home/mythtv/.mythtv/config.xml
RUN mkdir /home/mythtv/.mythtv/channels && chown mythtv:mythtv /home/mythtv/.mythtv/channels
ADD ./add/channels /home/mythtv/.mythtv/channels
ADD ./add/find_orphans.py /home/mythtv/
ADD ./add/apache.ini /etc/supervisor.d/apache.ini
ADD ./add/mythbackend.ini /etc/supervisor.d/mythbackend.ini
ADD ./add/startup /usr/bin/startup
RUN chmod +x /usr/bin/startup /home/mythtv/find_orphans.py
CMD ["/usr/bin/startup"]
