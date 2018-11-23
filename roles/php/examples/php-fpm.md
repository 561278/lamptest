# Example - PHP 7.0 Sapi FPM

```yaml
---
php_version          : '7.0'
php_sapi             : 'fpm'

php_modules:
  - gd
  - curl
  - mcrypt
  - mysqlnd
  - memcached

php_ini:
  post_max_size:      '64M'
  memory_limit :      '128M'

php_ini_cli:
  allow_url_fopen:    'On'

php_fpm:
  log_level: 'error'
  rlimit_files: 1048576
  
php_fpm_pools:
  
  - name: 'www'
  
  - name: 'mypool2'
    user: 'userweb2'
    group: 'userweb2'
    listen_owner: 'www-data'
    listen_group: 'www-data'
    pm: 'static'
    pm_max_children: 10

  - name: 'mypool3'
    user: 'userweb3'
    pm: 'static'
    pm_max_children: 20
    php_admin_value:
      upload_tmp_dir: /var/www/userweb2/tmp
      open_basedir: /var/www/userweb2/
      session.save_path: "/var/lib/php5/mypool3.sessions"
    php_value:
      assert.active                  : 0
      mbstring.http_input            : "pass"
      mbstring.http_output           : "pass"
      always_populate_raw_post_data  : -1
    php_flag:
      session.auto_start             :  "off"
      mbstring.encoding_translation  :  "off"
