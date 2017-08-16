FROM jeboehm/php-nginx-base:latest
MAINTAINER Michael Weber <micha.bgl@gmx.de>

ENV \
    MYSQL_HOST=db \
    MYSQL_USER=root \
    MYSQL_PASSWORD=root \
    MYSQL_DATABASE=shopware

RUN apk --no-cache add \
      mariadb-client \
      apache-ant && \
    wget -O /root/test_images.zip http://releases.s3.shopware.com/test_images.zip

ADD https://raw.githubusercontent.com/commic/docker-shopware/master/rootfs/usr/local/bin/entrypoint.sh /usr/local/bin
ADD https://raw.githubusercontent.com/commic/docker-shopware/master/rootfs/usr/local/bin/wait-mysql.sh /usr/local/bin
ADD https://raw.githubusercontent.com/commic/docker-shopware/master/rootfs/usr/local/etc/php/conf.d/limits.ini /usr/local/etc/php/conf.d/
ADD https://raw.githubusercontent.com/commic/docker-shopware/master/rootfs/etc/nginx/global/shopware.conf /etc/nginx/global/
ADD https://raw.githubusercontent.com/commic/docker-shopware/master/rootfs/etc/nginx/sites-enabled/10-docker.conf /etc/nginx/sites-enabled/
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
RUN ["chmod", "+x", "/usr/local/bin/wait-mysql.sh"]
ONBUILD VOLUME /var/www/html

CMD [""]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
