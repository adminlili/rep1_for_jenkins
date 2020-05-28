# main image for container
FROM debian:latest

# who made cont?
MAINTAINER admin_lili
ENV DEBIAN_FRONTEND=noninteractive
# rewrite FILES in dir /var/www/ by ./html on remote container
# COPY works only with files!!!
COPY ./html/* /var/www/
RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y tzdata && \
#	dpkg-reconfigure --frontend noninteractive tzdata &&\
	apt-get install -y apache2 && \
	echo "servername apache" | tee -a /etc/apache2/apache2.conf && \
	service apache2 restart
EXPOSE 80/tcp
# the ability to stop term with Ctrl+C
STOPSIGNAL SIGTERM
CMD ["apache2ctl", "-D", "FOREGROUND"]
#CMD ["bin/bash"]
