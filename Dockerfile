# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rvoltigo <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/22 15:20:58 by rvoltigo          #+#    #+#              #
#    Updated: 2020/12/26 16:01:45 by rvoltigo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
LABEL maincontainer = "rvoltigo@student.21-school.ru"

RUN apt-get -y update

RUN apt-get -y install nginx
RUN apt-get -y install wget
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
RUN apt-get -y install openssl
RUN apt-get -y install mariadb-server

RUN openssl req -x509 -nodes -days 365 -subj "/C=RF/ST=Kazan/L=Kazan/O=school21/OU=school21/CN=rvoltigo" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin && rm -rf phpMyAdmin-5.0.1-english
COPY ./srcs/config.inc.php phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php wordpress

COPY ./srcs/nginx.conf /etc/nginx/sites-available/default

RUN chmod -R 755 /var/www/*

COPY ./srcs/init.sh /var/www
RUN rm index.nginx-debian.html

CMD bash /var/www/init.sh
EXPOSE 80 443

