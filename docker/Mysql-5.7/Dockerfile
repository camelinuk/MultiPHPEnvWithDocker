#FROM mysql:5.7
FROM centos/mysql-57-centos7

MAINTAINER James Chen<james.chen@lemon.cx>

#RUN chown -R mysql:root /var/lib/mysql/

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_USER=$MYSQL_USER
ENV MYSQL_PASSWORD=$MYSQL_PASSWORD
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

#ADD data.sql /etc/mysql/data.sql

#RUN sed -i 's/MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /etc/mysql/data.sql
#RUN cp /etc/mysql/data.sql /docker-entrypoint-initdb.d

VOLUME ["/var/lib/mysql"]

#COPY docker-entrypoint.sh /entrypoint.sh
#COPY healthcheck.sh /healthcheck.sh
#ENTRYPOINT ["/entrypoint.sh"]
#HEALTHCHECK CMD /healthcheck.sh

EXPOSE 3306 33060 33061
CMD ["mysqld"]

