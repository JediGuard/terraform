#!/bin/bash
sudo su 
apt update -y &&
apt install -y nginx
cd /var/www/
rm -rf /var/www/html
git clone --depth 1 https://github.com/JediGuard/comingsoonpage html
cd /var/www/
chmod -R 0755 www-data:www-data /html
chown -R www-data:www-data /html
systemctl rstart nginx

#NEXT STEP
# sudo apt install curl 
# curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
# source ~/.bashrc   
# nvm install 20.10.0
# nvm use 20.10.0
# npm install -g pnpm
# npm install -g @angular/cli
# npm install -g @nestjs/cli