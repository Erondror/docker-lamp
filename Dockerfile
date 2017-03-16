FROM ubuntu:14.04
MAINTAINER Hugo BARROUX <hubarroux@erondror.fr>

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Update sources
RUN apt-get update -y

# install http
RUN apt-get install -y apache2 vim bash-completion unzip
RUN mkdir -p /var/lock/apache2 /var/run/apache2

# install mysql
RUN apt-get install -y mysql-client mysql-server
#RUN echo "NETWORKING=yes" > /etc/sysconfig/network
# start mysqld to create initial tables
#RUN service mysqld start

# install php
RUN apt-get install -y php5 php5-mysql php5-dev php5-gd php5-memcache php5-pspell php5-snmp snmp php5-xmlrpc libapache2-mod-php5 php5-cli
#RUN yum install -y php php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml

# install composer

RUN curl -sS https://getcomposer.org/installer | php
RUN sudo mv composer.phar /usr/local/bin/composer.phar
RUN alias composer='/usr/local/bin/composer.phar'

# others

ADD phpinfo.php /var/www/html/
EXPOSE 80 443

CMD ["supervisord", "-n"]
