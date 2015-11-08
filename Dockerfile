FROM debian:stable

MAINTAINER Leonard Marschke <leonard@marschke.me>

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

RUN wget `curl -s https://api.github.com/repos/andryyy/mailcow/releases | grep tarball_url | head -n 1 | cut -d '"' -f 4` -O - | tar -xzf - && mv andryyy-mailcow* mailcow
RUN cd mailcow && set -x && bash install.sh

#clean up
RUN apt-get clean

RUN rm -rf /var/lib/apt/lists/*
