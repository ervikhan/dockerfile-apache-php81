ARG IMAGE_NAME=ubuntu
ARG IMAGE_TAG=20.04

FROM ${IMAGE_NAME}:${IMAGE_TAG}

MAINTAINER ervikhan <m.ervikhan@gmail.com>
LABEL service="Apache-PHP7.2"
LABEL base_os="Ubuntu 20.04"

RUN apt update

#Install requirement attribut
RUN DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common wget zip git && apt clean all
#Add repository for php services
RUN add-apt-repository ppa:ondrej/php -y

RUN apt update

#Install apache2
RUN DEBIAN_FRONTEND=noninteractive apt -y install apache2 && apt clean all
RUN service apache2 start
RUN a2enmod rewrite
RUN service apache2 restart
#Install php & extension
RUN apt install php7.2 -y && apt clean all
RUN apt install php7.2-mysql php7.2-cgi php7.2-zip libapache2-mod-php7.2 php7.2-curl php7.2-common php7.2-mbstring php7.2-pgsql php7.2-gd php7.2-cli php7.2-soap php7.2-intl php7.2-xml php7.2-mcrypt php7.2-opcache php7.2-bcmath php7.2-calendar php7.2-gettext php7.2-mysqlnd php7.2-xmlrpc php7.2-xmlreader php7.2-tokenizer php7.2-sysvshm php7.2-sysvsem php7.2-sysvmsg php7.2-sqlite3 php7.2-sockets php7.2-simplexml php7.2-posix php7.2-phar php7.2-shmop php7.2-iconv php7.2-ldap php7.2-json php7.2-ftp php7.2-ctype php7.2-dom php7.2-fileinfo php7.2-pdo php7.2-redis  -y && apt clean all
#Install php composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Start apache and run bash
CMD service apache2 restart && /bin/bash