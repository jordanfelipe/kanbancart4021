#!/bin/bash
sudo rm -r /var/www/html/
sudo rm -r /var/www/storage-main/
sudo mkdir /var/www/html/
sudo cp -r ~/tmp/upload/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
    sudo find /var/www/html/ -type d -exec chmod 770 {} +;
    sudo find /var/www/html/ -type d -execdir setfacl -m u:jordan:rwx -m o::--- {} +;
    sudo find /var/www/html/ -type f -exec chmod 660 {} +;
    sudo find /var/www/html/ -type f -exec setfacl -m u:jordan:rw -m o::--- {} +;
    sudo find /var/www/html/ -type d -exec chmod g+s {} +;
chmod 770 /var/www/html/config.php
chmod 770 /var/www/html/admin/config.php

# Install Opencart.

sudo mv /var/www/html/system/storage/ /var/www/storage-main/
nano /var/www/html/config.php 
    # // Change
    # define('DIR_STORAGE', DIR_OPENCART . 'storage/');
    # // To
    # define('DIR_STORAGE', '/var/www/storage-main/');
nano /var/www/html/admin/config.php
    # // Change
    # define('DIR_STORAGE', DIR_OPENCART . 'storage/');
    # define('HTTP_SERVER', 'http://kanbancart.com/admin/');
    # // To
    # define('DIR_STORAGE', '/var/www/storage-main/');
    # define('HTTP_SERVER', 'http://kanbancart.com/socuda2538/');
mv /var/www/html/admin /var/www/html/socuda2538