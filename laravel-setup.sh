apt update && apt upgrade -y # いつもの
apt install -y software-properties-common # add-apt-repositoryのインストール
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php # php のリポジトリを追加
apt install -y php8.1 php8.1-intl php8.1-mbstring php8.1-mysql php8.1-gd php8.1-fpm # php系をインストール