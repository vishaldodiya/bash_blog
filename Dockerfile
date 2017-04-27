FROM alpine:latest

RUN wget http://www.sqlite.org/2017/sqlite-autoconf-3170000.tar.gz

RUN tar xvfz sqlite-autoconf-3170000.tar.gz

RUN apk add --update alpine-sdk

RUN ./sqlite-autoconf-3170000/configure --prefix=/usr

RUN make

RUN make install

RUN rm sqlite-autoconf-3170000.tar.gz

COPY ./mysql/init.sql ./init.sql

COPY /blog.sh /blog.sh

RUN mkdir db_data

RUN touch ./db_data/bash_blog.db

RUN sqlite3 ./db_data/bash_blog.db < init.sql







