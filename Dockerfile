FROM alpine:latest

RUN wget http://www.sqlite.org/2017/sqlite-autoconf-3170000.tar.gz

RUN tar xvfz sqlite-autoconf-3170000.tar.gz

RUN apk add --update alpine-sdk

RUN ./sqlite-autoconf-3170000/configure --prefix=/usr

RUN make

RUN make install

RUN rm sqlite-autoconf-3170000.tar.gz

RUN touch outlog.log

VOLUME ./logs/outlog.log:./outlog.log

COPY ./mysql/init.sql ./init.sql

RUN touch ./bash_blog.db

VOLUME ./db_data:./bash_blog.db

COPY ./blog.sh ./blog.sh

RUN sqlite3 bash_blog.db < init.sql




