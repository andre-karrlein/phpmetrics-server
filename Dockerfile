FROM php:7.2-cli

RUN apt-get update && apt-get install -y git zip

RUN mkdir -p /var/www/ && \
    cd /var/www/ && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup');"

RUN cd /var/www/ && \
    php composer.phar require phpmetrics/phpmetrics

COPY script.sh /var/www/script.sh

CMD ["bash", "/var/www/script.sh"]
