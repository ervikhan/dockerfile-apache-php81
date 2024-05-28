ARG IMAGE_NAME=ubuntu
ARG IMAGE_TAG=20.04

FROM ${IMAGE_NAME}:${IMAGE_TAG}

MAINTAINER ervikhan <m.ervikhan@gmail.com>
LABEL service="Apache-PHP7.4"
LABEL base_os="Ubuntu 20.04"

RUN apt update

#Install requirement attribut
RUN DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common wget zip git && apt clean all
#Add repository for php services
RUN add-apt-repository ppa:ondrej/php -y

RUN apt update

#Install requirement attribut
RUN DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common wget zip \
git nano vim && apt clean all
#Add repository for php services
RUN add-apt-repository ppa:ondrej/php -y

RUN apt update

#Install apache2
RUN DEBIAN_FRONTEND=noninteractive apt -y install apache2 && apt clean all
RUN service apache2 start
RUN a2enmod rewrite
RUN service apache2 restart
#Install php & extension
RUN apt install php7.4 -y && apt clean all
RUN apt install php7.4-mysql php7.4-cgi libapache2-mod-php7.4 php7.4-curl \
php7.4-common php7.4-mbstring php7.4-pgsql php7.4-gd php7.4-cli php7.4-soap \
php7.4-intl php7.4-xml php7.4-mcrypt php7.4-opcache php7.4-bcmath php7.4-calendar \
php7.4-gettext php7.4-mysqlnd php7.4-xmlrpc php7.4-xmlreader php7.4-tokenizer \
php7.4-sysvshm php7.4-sysvsem php7.4-sysvmsg php7.4-sqlite3 php7.4-sockets \
php7.4-simplexml php7.4-posix php7.4-phar php7.4-shmop php7.4-iconv php7.4-ldap \
php7.4-json php7.4-ftp php7.4-ctype php7.4-dom php7.4-fileinfo php7.4-pdo php7.4-redis \
php7.4-zip -y && apt clean all
#Install php composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Start apache and run bash
CMD service apache2 restart && /bin/bash