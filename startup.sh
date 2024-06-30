#!/bin/bash

if [ -d /var/www/html/setup ]; then
    echo "Setup directory found. Performing setup..."
else
    echo "Setup directory not found. Skipping setup..."
    
    curl -L https://github.com/ILIAS-eLearning/ILIAS/releases/download/v9.2/ILIAS-9.2.tar.gz | tar -xz -C /var/www/temp

    mv /var/www/temp/ILIAS-9.2/* /var/www/html/
    rm -rf /var/www/temp/ILIAS-9.2*

    cd /var/www/html

    composer install --no-dev

    npm cache clean --force
    npm install --production

    chown -R www-data:www-data /var/www/html
    mkdir -p /var/www/files
    chown -R www-data:www-data /var/www/files

    php setup/setup.php install /var/www/config/minimal-config.json
fi

# 启动 Apache 服务
apache2 -foreground &