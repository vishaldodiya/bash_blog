#!bin/bash

docker build -t "bash_blog" .

#edocker run -it bash_blog sqlite3 bash_blog.db < init.sql

docker run -it bash_blog /bin/sh



