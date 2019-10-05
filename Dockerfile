FROM golang:alpine

RUN apk add php git zip

RUN mkdir -p /var/www/ && \
    cd /var/www/ && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup');"

RUN cd /var/www/ && \
    php composer.phar require phpmetrics/phpmetrics

COPY main.go /var/www/generator.go
COPY server.go /var/www/server.go
RUN go run generator.go

CMD ["go", "run", "/var/www/server.go"]
