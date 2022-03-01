FROM ubuntu:21.10

RUN apt update && apt upgrade -y \
  apt install -y software-properties-common \
  LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
  apt install -y php8.1 php8.1-intl php8.1-mbstring php8.1-mysql php8.1-gd php8.1-fpm