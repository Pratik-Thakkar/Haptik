FROM ubuntu:trusty
MAINTAINER pratik

# Install packages: mysql adds a root user with no password
ENV DEBIAN_FRONTEND noninteractive \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get update && \
  apt-get -yq install mysql-server && \
  rm -rf ${MYSQL_DATA_DIR} && \
  rm -rf /var/lib/apt/lists/*

# setup our entry point
ADD init.sh /init.sh
RUN chmod 755 /*.sh
ENTRYPOINT ["/init.sh"]

EXPOSE 3306
CMD ["mysqld_safe"]