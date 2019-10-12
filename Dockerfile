FROM golang as builder

COPY src/ /go/build/
WORKDIR /go/build/

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o phpmetrics-server .

FROM alpine:3.10

RUN apk add --update \
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
    php -r "unlink('composer-setup.php');"

RUN php composer.phar require phpmetrics/phpmetrics

COPY template.html /var/www/template.html
COPY --from=builder /go/build/phpmetrics-server /var/www/phpmetrics-server

EXPOSE 8080

CMD ["/var/www/phpmetrics-server"]
