ARG IMAGE_NAME=ubuntu
ARG IMAGE_TAG=20.04

FROM ${IMAGE_NAME}:${IMAGE_TAG}

MAINTAINER ervikhan <m.ervikhan@gmail.com>
LABEL service="Apache-PHP7.3"
LABEL base_os="Ubuntu 20.04"

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
RUN apt install php7.3 -y && apt clean all
RUN apt install php7.3-mysql php7.3-cgi libapache2-mod-php7.3 php7.3-curl \
php7.3-common php7.3-mbstring php7.3-pgsql php7.3-gd php7.3-cli php7.3-soap \
php7.3-intl php7.3-xml php7.3-mcrypt php7.3-opcache php7.3-bcmath php7.3-calendar \
php7.3-gettext php7.3-mysqlnd php7.3-xmlrpc php7.3-xmlreader php7.3-tokenizer \
php7.3-sysvshm php7.3-sysvsem php7.3-sysvmsg php7.3-sqlite3 php7.3-sockets \
php7.3-simplexml php7.3-posix php7.3-phar php7.3-shmop php7.3-iconv php7.3-ldap \
php7.3-json php7.3-ftp php7.3-ctype php7.3-dom php7.3-fileinfo php7.3-pdo php7.3-redis \
php7.3-zip -y && apt clean all

#Install php composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Set Timezone Asia/Jakarta
RUN apt install tzdata -y
ENV TZ="Asia/Jakarta"

#Start apache and run bash
CMD service apache2 restart && /bin/bash