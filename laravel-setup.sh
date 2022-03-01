# いつもの
apt update && apt upgrade -y

# php導入
apt install -y software-properties-common # add-apt-repositoryのインストール
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php # php のリポジトリを追加
apt install -y php8.1 php8.1-intl php8.1-dom php8.1-curl php8.1-mbstring php8.1-mysql php8.1-gd php8.1-fpm # php系をインストール

# composer導入
apt install -y curl php-cli php-mbstring git unzip # 依存関係ファイルのインストール
php -r "copy ( 'https://getcomposer.org/installer', 'composer-setup.php' ) ;"; # composer インストーラーのダウンロード
php composer-setup.php --install-dir=/usr/local/bin --filename=composer; # composer インストーラー実行

# php設定
echo 2 | update-alternatives --config php
php --ini | grep "Loaded Configuration File" | sed -e 's/.*=> //g' | xargs sed -i -e "s/;extension=curl/extension=curl/g"

# Laravelプロジェクトの作成
<< LARAVEL_BUILD
composer create-project laravel/laravel --prefer-dist laravel-test
cd laravel-test
composer install
php artisan serve
LARAVEL_BUILD