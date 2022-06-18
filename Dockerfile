FROM mysql

ADD sample-database.sql /docker-entrypoint-initdb.d

EXPOSE 3306
