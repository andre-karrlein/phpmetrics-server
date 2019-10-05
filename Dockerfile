FROM golang:alpine

RUN apk add \
php \
php-openssl \
php-mbstring \
php-phar \
php-json \
php-xml \
php-dom \
php-tokenizer \
git \
zip

RUN mkdir -p /var/www/

WORKDIR /var/www

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup');"

RUN php composer.phar require phpmetrics/phpmetrics

COPY main.go /var/www/generator.go
COPY server.go /var/www/server.go
COPY template.html /var/www/template.html

CMD go run /var/www/generator.go && go run /var/www/server.go
