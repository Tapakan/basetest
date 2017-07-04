# Use an official PHP runtime as a base image
FROM hexaua/dev

# ADD copyright
LABEL maintainer "a.ohanov@hexa.com.ua"

# Install any needed packages
RUN pecl install xdebug-2.5.0 \
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

