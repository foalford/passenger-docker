FROM phusion/baseimage:0.9.15
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
RUN mkdir /build
RUN echo 'Acquire::http { Proxy "http://jin:3142"; };' >> /etc/apt/apt.conf.d/01proxy
ADD . /build
RUN /build/install.sh
CMD ["/sbin/my_init"]
RUN rm /etc/apt/apt.conf.d/01proxy
EXPOSE 80 443
