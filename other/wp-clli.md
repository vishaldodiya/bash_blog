# pull alpine image and run

`docker pull alpine:latest` \
`docker run -it alpine:latest /bin/sh`

# install alpine sdk

`apk add --update alpine-sdk`

# install php-cli

`apk add --update php5-cli php5-phar`

# download Wp-cli

`curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar`

# install wp-cli

`php5 wp-cli.phar --info`


# Create database
`sqlite3 bash_blog.db`

# To print datbases
`.databases`

# Create table
`CREATE TABLE post(`
`post_id INT PRIMARY KEY NOT NULL,`
`title TEXT NOT NULL,`
`content CHAR(200),`
`category_id INT);`

# To print tables
`.tables`

# To check schema
`.schema table_name`

# sqlite with bash 
` rlwrap sqlite3`





