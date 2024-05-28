ARG IMAGE_NAME=ubuntu
ARG IMAGE_TAG=20.04

FROM ${IMAGE_NAME}:${IMAGE_TAG}

MAINTAINER ervikhan <m.ervikhan@gmail.com>
LABEL service="Apache-php8.1"
LABEL base_os="Ubuntu 20.04"

RUN apt update

#Install requirement attribut
RUN DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common \
wget zip git && apt clean all
#Add repository for php services
RUN add-apt-repository ppa:ondrej/php -y

RUN apt update

#Install apache2
RUN DEBIAN_FRONTEND=noninteractive apt -y install apache2 && apt clean all
RUN service apache2 start
RUN a2enmod rewrite
RUN service apache2 restart
#Install php & extension
RUN apt install php8.1 -y && apt clean all
RUN apt install php8.1-mysql php8.1-cgi php8.1-zip libapache2-mod-php8.1 php8.1-curl \
php8.1-common php8.1-mbstring php8.1-pgsql php8.1-gd php8.1-cli php8.1-soap \
php8.1-intl php8.1-xml php8.1-mcrypt php8.1-opcache php8.1-bcmath php8.1-calendar \
php8.1-gettext php8.1-mysqlnd php8.1-xmlrpc php8.1-xmlreader php8.1-tokenizer \
php8.1-sysvshm php8.1-sysvsem php8.1-sysvmsg php8.1-sqlite3 php8.1-sockets \
php8.1-simplexml php8.1-posix php8.1-phar php8.1-shmop php8.1-iconv php8.1-ldap \
php8.1-ftp php8.1-ctype php8.1-dom php8.1-fileinfo php8.1-pdo php8.1-redis \
-y && apt clean all

#Install php composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Start apache and run bash
CMD service apache2 restart && /bin/bash