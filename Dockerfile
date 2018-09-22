FROM php:apache
WORKDIR /srv/themosis

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get -y update
RUN apt-get -y install apt-utils
RUN apt-get -y install git unzip

RUN docker-php-ext-install -j$(nproc) mysqli

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --working-dir=/srv create-project themosis/themosis themosis

ENV APACHE_DOCUMENT_ROOT="/srv/themosis/htdocs"
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY . htdocs/content/plugins/radioco

RUN touch .env
