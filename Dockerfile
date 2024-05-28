ARG IMAGE_NAME=ubuntu
ARG IMAGE_TAG=20.04

FROM ${IMAGE_NAME}:${IMAGE_TAG}

MAINTAINER ervikhan <m.ervikhan@gmail.com>
LABEL service="Apache-PHP5.6"
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
RUN apt install php5.6 -y && apt clean all
RUN apt install php5.6-mysql php5.6-cgi libapache2-mod-php5.6 php5.6-curl php5.6-common php5.6-mbstring php5.6-zip php5.6-pgsql php5.6-gd php5.6-cli php5.6-soap php5.6-intl php5.6-xml php5.6-mcrypt php5.6-opcache php5.6-bcmath php5.6-calendar php5.6-gettext php5.6-mysqlnd php5.6-xmlrpc php5.6-xmlreader php5.6-tokenizer php5.6-sysvshm php5.6-sysvsem php5.6-sysvmsg php5.6-sqlite3 php5.6-sockets php5.6-simplexml php5.6-posix php5.6-phar php5.6-shmop -y && apt clean all
#Install php composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Start apache and run bash
CMD service apache2 restart && /bin/bash