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