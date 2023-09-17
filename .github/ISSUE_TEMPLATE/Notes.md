### 14JUN2023:

- Rebuild server to Ubuntu 22.04 LTS.
- For DigitalOcean, recover root password via email.
- Create user jordan.
    - `useradd -m jordan`  // m: with home
    - `passwd jordan` // create password for jordan 
    - `su jordan` // switch to jordan
    - `groupadd -aG sudo jordan` // add jordan to sudoers
    - `cd` // go home 
- Update sudo information.
    - `usermod -aG sudo username` // add jordan to sudoers 
    - `EDITOR=nano visudo` // use nano to edit sudo file
    - `visudo` // edit sudo file
    - Add `Defaults        timestamp_timeout=60` to file // update sudo timeout 
- Upload template .bashrc file. 
- To allow ssh with key, generate ssh files.
    - **Look into disallowing other types of login. I didn't do that this last time.**
    - `mkdir .ssh` 
    - `cd .ssh`
    - `nano authorized_keys` // **consolidate this and the last two**
    - Add public keyfile.
- SSH in.
- Update system.
- Install AMP+.
    - Packages: **php**, **apache2**, **mariadb-server**, **php-mysql**, **php-curl**, **php-gd**, **php-xml**, **php-zip**
- MariaDB setup.
    - `sudo mysql_secure_installation`
    - Don't set root password.
    - Answer 'yes' to configuration options.
- MariaDB admin user.
    - `sudo mariadb`
    - ``GRANT ALL ON *.* TO `admin`@`localhost` IDENTIFIED BY '[password]' WITH GRANT OPTION;`` // replace [password]
    - `FLUSH PRIVILEGES;`
    - `CREATE TABLE kanbancart;`
    - ``CREATE USER `kanbanshop`@`localhost` INDENTIFIED BY '[password]';`` // replace [password]
    - ``GRANT CREATE, DELETE, DROP, EXECUTE, INSERT, SELECT, UPDATE ON `kanbancart`.* TO `kanbanshop`@`localhost`;``
    - `FLUSH PRIVILEGES;`
    - `exit;`
- Start apache2 server.
    - `sc start apache2.service`
    - `sc enable apache2.service`


### 15JUN2023:

- Restrict IP access.
    - // Upload 000-default.conf. Edit IP address.
- Clone git repository.
    - `git clone https://[REPOSITORY_URL]`
    - `git config --global user.name "Jordan Felipe"`
    - `git config --global user.email "jordanfelipe402@gmail.com"`
- Follow install instructions INSTALL.md.
    - // In /var/www/html/[HTML_FOLDER].
    - `sudo chown -R www-data ./*`
    - `sudo chgrp -R www-data ./*`
    - `sudo chmod 770 config.php`
    - `cd admin/`
    - `sudo chmod 770 config.php`


### 16JUN2023:

- Move storage directory.
    - `sudo mv /var/www/html/system/storage/ /var/www/html/storage-main/`
    - `sudo nano /var/www/html/config.php`
        - Change 
            - `define('DIR_STORAGE', DIR_OPENCART . 'storage/');` 
        - To
            - `define('DIR_STORAGE', '/var/www/storage-main/');`
    - `sudo nano /var/www/html/admin/config.php`
        - Change 
            - `define('DIR_STORAGE', DIR_OPENCART . 'storage/');` 
        - To
            - `define('DIR_STORAGE', '/var/www/storage-main/');`
- Rename admin directory
    - `sudo mv /var/www/html/admin/ /var/www/html/[NEW NAME]/`
    - `sudo nano /var/www/html/[NEW NAME]/config.php`
        - Change 
            - `define('HTTP_SERVER', 'http://kanbancart.com/admin/');`
            - `define('DIR_APPLICATION', DIR_OPENCART . 'admin/');`
        - To
            - `define('HTTP_SERVER', 'http://kanbancart.com/[NEW NAME]/');`
            - `define('DIR_APPLICATION', DIR_OPENCART . '[NEW NAME]/');`


### 19JUN2023:

#### (20JUN2023: Clean up and tested entries.)

- Set `html/` permissions
    - `cd /var/www/html` // **Verify this.**
    - `sudo chown -R www-data:www-data ./;` // Change owner:group.
    - `sudo find /var/www/html -type d -exec chmod u+rwx {} +;` // Add www-data and user read, write, execute to all directories.
    - `sudo find /var/www/html -type d -execdir setfacl -m u:jordan:rwx -m o::--- {} +;`
    - `sudo find /var/www/html -type f -exec chmod u+rw {} +;` // Add www-data and user read, write to all files.
    - `sudo find /var/www/html -type f -exec setfacl -m u:jordan:rw -m o::--- {} +;`
    - `sudo find /var/www/html -type d -exec chmod g+s {} +;` // Set GID so future files maintain permissions.


### 20JUN2023: 

**Check this last command. Group flag s bit is set (-s-), but confirm it works.** 

- User `jordan` can rwx as needed.
- `www-data` seems to be forbidden. 
- www-data user:group is currently `www-data:www-data`.


### 21JUN2023:

- `/var/www/html` user:group had to be updated to www-data:www-data
    - `sudo chown www-data:www-data /var/www/html/`


### 26JUN2023:

- Currently working on modifications. 
- Significant structural changes have been made. 
- OCMOD was removed in v4.0. The replacement is Events which initially seem to be insufficient.
- There is a vQmod extension available. Extension breaks after step 1 vQmod installation.
- May be due to non-default naming of `admin` directory.
- Reloaded site using official release 4.0.2.1. I will try not renaming the `admin` directory. Also, I wanted to use a more stable release base. 
- Don't forget to read your own instructions.
- Site reloaded. Trying clicker_vqmod_manager.ocmod first without renaming `admin` directory.

#### Alternate settings:
- Follow install instructions INSTALL.md.

- Set `html/` permissions
    - `cd /var/www/html` // **Verify this.**
    - `sudo chown -R www-data:www-data ./;` // Change owner:group.
    - `sudo find /var/www/html -type d -exec chmod 770 {} +;` // Add www-data and user read, write, execute to all directories.
    - `sudo find /var/www/html -type d -execdir setfacl -m u:jordan:rwx -m o::--- {} +;`
    - `sudo find /var/www/html -type f -exec chmod 660 {} +;` // Add www-data and user read, write to all files.
    - `sudo find /var/www/html -type f -exec setfacl -m u:jordan:rw -m o::--- {} +;`
    - `sudo find /var/www/html -type d -exec chmod g+s {} +;` // Set GID so future files maintain permissions.
- Move storage directory.
    - In `/var/www/html/[HTML_FOLDER]` when separating sites.
    - `sudo mv /var/www/html/system/storage/ /var/www/storage-main/`
    - `sudo nano /var/www/html/config.php`
        - Change
            - `define('DIR_STORAGE', DIR_OPENCART . 'storage/');`
        - To
            - `define('DIR_STORAGE', '/var/www/storage-main/');`
    - `sudo chmod 770 config.php`
    - `cd admin/`
    - `sudo nano /var/www/html/admin/config.php`
        - Change
            - `define('DIR_STORAGE', DIR_OPENCART . 'storage/');`
        - To
            - `define('DIR_STORAGE', '/var/www/storage-main/');`
    - `sudo chmod 770 config.php`


### 28JUN2023:

- Site reloaded with 4.0.2.1. 
- Loaded clicker_vqmod_manager.ocmod without renaming `admin` directory. 


### 30JUN2021:

- **php-xml** Package is needed for the vQmod manager.
- Check out this "SEO URL".
- Date added/modified format to be changed to MM/DD/YYYY hh:mm.
- Modifications need an `<id>` tag.
    - Example: `<id>admin_language_en-gb</id>`


### 01JUL2023:

- I forgot to replace the `db-schema.php` file. 
- Reloading site for practice rather than adding columns which is more time-consuming.
- Site reloaded with `admin/` folder name changed. Worked out of the box due to the **pathReplaces.php** if statement.
- **TODO:** Make a separate function call for each additional piece of information in **Admin_Controller_Sale_Order.ocmod.xml**. 
    - Currently, `$this->model_sale_order->getProductInfo` call returns array.


### 02JUL2023:

- Got **Admin_Sale_Order** modifications working. 
- Using separate functions for each custom information. 
- TODO: Make a single function to do this. Handling arrays makes a bit more sense now. Perform one inital call to the function. 
    - Query and distribute **uom** variables.
    - Rewrite javascript to auto-complete certain fields. Try using existing id/class.


### 04JUL2023:

- Used Let's Encrypt via certbot to get SSL. Updated the **config.php** files messily. 
- Front end works. 
- Admin Login and password reset are not working. Error referenced not "username and/or password" found. 


### 06JUL2023:

- **Compare db_schema of current git version to stable 4.0.2.1 verson.**


### 08JUL2023:

- Might reload site. 
- Rename **admin** directory: 
    - `sudo mv /var/www/html/admin /var/www/html/[NEW NAME]`
    - `nano /var/www/html/config.php`
    - `nano /var/www/html/[NEW_NAME]/config.php`


### 09JUL2023:

- Reloaded site. SSL issue persists.
- Try disabling SSL delivery on server. 
- I didn't follow the "# Install Opencart" instruction.
- Deleted SSL certificate. Used Private Window. successfully got <http://kanbancart.com> to load.
- Admin side sending blank page via http after renaming and reconfiguring admin/ directory name. 
    - I havent't seen this before. Check configuration files and spelling throughout. 


### 10JUL2023: 

- Reloading site.
- I think I uploaded the wrong kanban 'upload' directory. The one from `~/tmp` rather than `~/Documents/KanbanCart`. 
- Updating **KC_INSTALL.sh**.
- Worked using the correct kanban 'upload' directory. Additionally, the built in move/delete/rename features worked minus the special permissions.
    - These auto features mess up the ACL permissions. 
- Got it working. Change the urls from **http://** to **https://**. Don't change or add variables. That is what I did a previous time. 
- Seeing if changing timezone seting changes displayed times. 
    - Chaning timezone from UTC to America/Los_Angeles turns any mention of "Free Test" throws an error. 
        > Warning: Undefined array key "image" in /var/www/html/catalog/controller/product/search.php on line 193
            Unknown: html_entity_decode(): Passing null to parameter #1 ($string) of type string is deprecated in /var/www/html/catalog/controller/product/search.php on line 193
        Warning: Undefined array key "price" in /var/www/html/catalog/controller/product/search.php on line 200
        Warning: Undefined array key "tax_class_id" in /var/www/html/catalog/controller/product/search.php on line 200
        TypeError: Opencart\System\Library\Cart\Tax::calculate(): Argument #1 ($value) must be of type float, null given, called in /var/www/html/catalog/controller/product/search.php on line 200 in /var/www/html/system/library/cart/tax.php on line 93
- Changing timezone back to UTC.
    - Performed further tesing. Checked database, only image was blank. Tried selecting image, changing tax_class_id, meta tag title, price to no avail. 
    - It seems the lowest common denominator is that changing the timezone affect (at least) new products. Maybe negative time causes an error. i.e. Item gets called before having been created. 
    - Trying a different and smaller timezone offset. Africa/Porto_Novo (+01:00) worked. Asia/Karachi (+05:00) worked. America/Nuuk (-02:00) worked. 
    - Will try setting to America/Los_Angeles later, after at least 7 hours after having created product. Reverted product changes. 
    - Tested with Africa/Porto_Novo and time change are not retroactive, order times are written at the time of the action, see date_modified earlier than date_added for oder_id = 3. 
    - UTC order placed at 19:45 Los_Angeles (02:45 UTC) and 19:46 Los_Angeles (03:46 Porto_Novo).
    - Conversion at read is likely better. Consider making a module for this. 


### 11JUL2023:

- Working on UI.
    - Site doesn't warn of incorrect admin username/password. 
- When resetting base to 4.0.2.1, keep `./system/system/db_schema.php`, `./image/no_image.png`, and `./image/placeholder.png`
- **TODO:** Set no_image.png or placeholder.png as default image. 


### 19JUL2023: 

- Warning for "no admin username/password" is working. 


### 21JUL2023:

- Research what **stores** do.
- Multiple stores can be used for B31. 
- Can be separted via sub-domain on VHOST.
    - **TODO:**
    - Test Customer across multiple stores. **WORKS**
    - Test inventory multi-use. **WORKS**
    - Test email separation. **NOT AVAILABLE**
- Cart quantity adjustment/deletion not working on Default store. 
- Carts cross over between stores. 
- Email delivery from store/to customer doesn't seem to be working.
    - Needs package: **php-mail**.
    - Issue persists.
    - **Mail Engine** setting was set to none. May autopopulate with package installed before opencart install similar to `php-mysqli` issue.
    - Testing via Marketing > Mail. Success banner received on admin side. 
    - In `/var/www/html/php.ini`, uncommented or added:
        - display_errors = 1;
        - error_reporting = E_ALL;
        - extension=mail;
    - Installed package **sendmail**
- >PHP Warning:  PHP Startup: Unable to load dynamic library 'mysqli' (tried: /usr/lib/php/20210902/mysqli (/usr/lib/php/20210902/mysqli: cannot open shared object file: No such file or directory), /usr/lib/php/20210902/mysqli.so (/usr/lib/php/20210902/mysqli.so: undefined symbol: mysqlnd_global_stats)) in Unknown on line 0
    - Mail attemps are much slower after **sendmail** install. 
        - Timing out with error:
        - >unable to qualify my own domain name (concord) -- using short name
        My unqualified host name (concord) unknown; sleeping for retry


### 23JUL2023:

- Tried some **sendmail** troubleshooting to no avail. 
- Extensions to work on:


### 08SEP2023:

