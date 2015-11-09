FROM debian:stable

MAINTAINER Leonard Marschke <leonard@marschke.me>

EXPOSE 587
EXPOSE 465
EXPOSE 25
EXPOSE 143
EXPOSE 993
EXPOSE 80
EXPOSE 443

RUN mkdir /etc/mailcow

VOLUME ["/etc/mailcow", "/var/mail", "/etc/apache2", "/var/lib/mysql"]

#update software repos
RUN apt-get update

#ugrade software
RUN apt-get -y upgrade

RUN apt-get -y install apt-utils

#install some useful tools
RUN apt-get -y install \
        curl \
        wget \
        netcat \
        rsyslog \
        fail2ban

RUN mkdir /usr/local/mailcow

RUN wget `curl -s https://api.github.com/repos/andryyy/mailcow/releases | grep tarball_url | head -n 1 | cut -d '"' -f 4` -O - | tar -xzf - && mv andryyy-mailcow* /usr/local/mailcow
RUN mv /usr/local/mailcow/mailcow.config /etc/mailcow/mailcow.config
RUN cd /usr/local/mailcow && set -x && bash install.sh

#clean up
RUN apt-get clean

RUN rm -rf /var/lib/apt/lists/*