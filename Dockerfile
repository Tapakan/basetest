# Use an official PHP runtime as a base image
FROM php:latest

# ADD copyright
LABEL maintainer "a.ohanov@hexa.com.ua"

# Install any needed packages
RUN apt-get update \
    && apt-get install git \
    libcurl4-gnutls-dev \
    libicu-dev \
    libmcrypt-dev \
    libvpx-dev \
    libjpeg-dev \
    libpng-dev \
    libxpm-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libxml2-dev \
    libexpat1-dev \
    libbz2-dev \
    libgmp3-dev \
    libldap2-dev \
    unixodbc-dev \
    libpq-dev \
    libsqlite3-dev \
    libaspell-dev \
    libsnmp-dev \
    libpcre3-dev \
    libtidy-dev \
    wget \
    default-jre \
    xvfb \
    iceweasel \
    unzip -yqq \

    && wget http://selenium-release.storage.googleapis.com/2.52/selenium-server-standalone-2.52.0.jar \

    && docker-php-ext-install mbstring mcrypt curl intl gd xml zip bz2 bcmath pdo pdo_mysql openssl json ldap \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug

COPY ./.ssh/id_rsa.pub /root/.ssh/
COPY ./.ssh/id_rsa /root/.ssh/
COPY ./.ssh/known_hosts /root/.ssh/

RUN chmod 600 /root/.ssh/id_rsa \
    && chmod 600 /root/.ssh/id_rsa.pub \
    && eval `ssh-agent -s` \
    && ssh-add /root/.ssh/id_rsa \
    && apt-get purge -y g++ \
    && apt-get autoremove -y \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

