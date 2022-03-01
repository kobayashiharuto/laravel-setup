LARAVEL_APP_NAME="laravel-app"

# いつもの
apt update && apt upgrade -y

# apache導入
apt install -y apache2
systemctl start apache2

# apache設定
sed -i -e "s@var/www/@var/www/$LARAVEL_APP_NAME/public/@g" /etc/apache2/apache2.conf
sed -i -e "s@DocumentRoot /var/www/html@DocumentRoot /var/www/$LARAVEL_APP_NAME/public@g" /etc/apache2/sites-available/000-default.conf

# php導入
apt install -y software-properties-common # add-apt-repositoryのインストール
echo "\n" | LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php # php のリポジトリを追加
apt install -y php8.1 php8.1-intl php8.1-dom php8.1-curl libapache2-mod-php8.1 php8.1-mbstring php8.1-mysql php8.1-gd php8.1-fpm # php系をインストール

# composer導入
apt install -y curl php-cli php-mbstring git unzip # 依存関係ファイルのインストール
php -r "copy ( 'https://getcomposer.org/installer', 'composer-setup.php' ) ;"; # composer インストーラーのダウンロード
php composer-setup.php --install-dir=/usr/local/bin --filename=composer; # composer インストーラー実行

# php設定
echo 2 | update-alternatives --config php
php --ini | grep "Loaded Configuration File" | sed -e 's/.*: //g' | xargs sed -i -e "s/;extension=curl/extension=curl/g"

# apacheの再起動
systemctl restart apache2

# Laravelプロジェクトの作成
cd /var/www \
  && composer create-project laravel/laravel --prefer-dist $LARAVEL_APP_NAME \
  && cd $LARAVEL_APP_NAME \
  && chmod 777 bootstrap/cache -R \
  && chmod 777 storage -R \
  && composer install