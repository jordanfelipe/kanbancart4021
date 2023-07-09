#!/bin/bash
rm -r /var/www/html/
rm -r /var/www/storage-main/
cp ~/tmp/upload/ /var/www/html/
chown -R www-data:www-data /var/www/html/
find /var/www/html/ -type d -exec chmod 770 {} +
find /var/www/html/ -type d -execdir setfacl -m u:jordan:rwx -m o::--- {} +
find /var/www/html/ -type f -exec chmod 660 {} +
find /var/www/html/ -type f -exec setfacl -m u:jordan:rw -m o::--- {} +
find /var/www/html/ -type d -exec chmod g+s {} +
mv /var/www/html/system/storage/ /var/www/storage-main/
nano /var/www/html/config.php 
    # // Change
    # define('DIR_STORAGE', DIR_OPENCART . 'storage/');
    # // To
    # define('DIR_STORAGE', '/var/www/storage-main/');
chmod 770 /var/www/html/config.php
nano /var/www/html/admin/config.php
    # // Repeat above
chmod 770 /var/www/html/admin/config.php
mv /var/www/html/admin /var/www/html/socuda2538
nano /var/www/html/socuda2538/config.php
    # // Change
    # define('HTTP_SERVER', 'http://kanbancart.com/admin/');
    # // TO
    # define('HTTP_SERVER', 'http://kanbancart.com/socuda2538/');