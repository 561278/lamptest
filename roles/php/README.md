# PHP (AWH) - Ansible Role

## Description

This role install and configure **PHP** (sapi `cli`, `fpm` and `apache`)

## Requirement

- Ansible >= 2.0
- OS : (Debian / Ubuntu / Centos)

## Summary

* [Versions availables](#versions-availables-os)
* [Tags](#tags)
* [Extra Variables](#extra-variables)
* [Variables](#variables)
 * [Global](#global)
 * [List of global php.ini directives (FPM & Apache)](#list-of-global-phpini-directives-fpm-apache)
 * [List of global php.ini directives (Cli)](#list-of-global-phpini-directives-cli)
 * [List of global php-fpm.conf directives](#list-of-global-php-fpmconf-directives)
 * [List of pool directives](#list-of-pool-directives)
 * [List of Custom APT-Repository](#list-of-custom-apt-repository)
* [Exemples](#exemples)
* [Credits](#credits)
* [Licence](#licence)

## Versions availables / OS

| Version    |Debian Wheezy|Debian Jessie|Debian Stretch|Ubuntu Trusty|Ubuntu Xenial| Centos 6 | Centos 7 |
|------------|------|------|------|------|------|------|------|
| 5.3        |   √  |      |      |      |      |      |      |   
| 5.4        |   √  |      |      |      |      |   √  |      |   
| 5.5        |   √  |      |      |   √  |   √  |   √  |  √   |   
| 5.6        |   √  |   √  |   √  |   √  |   √  |   √  |  √   |   
| 7.0        |      |   √  |   √  |   √  |   √  |   √  |  √   |
| 7.1        |      |   √  |   √  |   √  |   √  |   √  |  √   |
| 7.2        |      |   √  |   √  |   √  |   √  |   √  |  √   |

This role **auto-pinning** php version. Just define `php_version` variable : `x.x.x` or `x.x`

This role **auto-select** apt-repository depending on php version and os, it's possible to use a custom repository with `php_repo` variable.


## Tags

|TAGS                                  |DESCRIPTION                                                     |
|--------------------------------------|----------------------------------------------------------------|
|php                                   | Limit to execute **all tasks** of this roles                   |
|php_install                           | Limit to execute **installation tasks**                        |
|php_configure                         | Limit to execute **configuration tasks**                       |
|php_sites                             | Limit to execute create **sites** deployement                  |


## Extra Variables

Use this variables with extra-data :

|VARIABLES                                  |  TYPES         |REQUIRE  |DEFAULT      |DESCRIPTION                                        |
|-------------------------------------------|----------------|---------|-------------|---------------------------------------------------|
|php_reinstall                              |  BOOLEAN       |  NO     |undefined    | Force reinstall php packages                      |
|php_purge                                  |  BOOLEAN       |  NO     |undefined    | Allow purge packages if version change            |


## Variables

#### Global

|VARIABLES                                  |  TYPES                                |REQUIRE |DEFAULT   |DESCRIPTION                                        |
|-------------------------------------------|---------------------------------------|--------|----------|---------------------------------------------------|
|php_version                                |STRING (Format `x.x` or `x.x.x`)       |NO      |`5.6`     | Version of php                                    |
|php_sapi                                   |STRING (`cli` or `fpm` or `apache`)    |NO      |`cli`     | Version of sapi.                                  |
|php_modules                                |LIST                                   |NO      |[]        | List of php modules with standard prefix          |
|php_modules_extras                         |LIST                                   |NO      |[]        | List of php modules **without** standard prefix   |
|php_ini                                    |HASHES                                 |NO      |{}        | php.ini                                           |
|php_ini_cli                                |HASHES                                 |NO      |{}        | php.ini cli - override php_ini                    |
|php_fpm                                    |HASHES                                 |NO      |          | Hashes de données relatif à la config du FPM php-fpm.conf |
|php_fpm_pools                              |LIST                                   |NO      |          | List of php-fpm pools |
|php_mod_php                                |BOOLEAN                                |NO      |false     | Force configuration of sapi apache|
|php_repo                                   |DICT                                   |NO      |undefined | List of custom repository                       |

#### List of global `php.ini` directives (FPM & Apache)

Just add key/value in `php_ini` variable :

Example :

    php_ini:
      post_max_size:       '32M'
      memory_limit :       '128M'
      allow_url_fopen:     'On'
      opcache.enabled :    '1'
      opcache.enable_cli : '0'

#### List of global `php.ini` directives (Cli)

The `php_ini_cli` variable override `php_ini`.

If you want override configuration for your php cli, just add key & value in `php_ini_cli` variable

Example :

    php_ini:
      memory_limit :      '128M'

    php_ini_cli:
      allow_url_fopen:    'On'
      memory_limit :      '512M'

Output php.ini cli :

    allow_url_fopen = On
    memory_limit = 512M



#### List of global `php-fpm.conf` directives

Set php fpm directives with `php_fpm` variable. Format `HASHES`

|VARIABLES                      |TYPES              |REQUIRE     |DEFAULT                 |DESCRIPTION                                                                  |
|-------------------------------|-------------------|------------|------------------------|-----------------------------------------------------------------------------|
|pid                            |PATH               |NO          |/run/php5-fpm.pid       |Path to PID file. Default value: none.                                       |
|sockdir                        |PATH               |NO          |/var/run                |Path où seront stocké les sockets.                                           |
|error_log                      |PATH               |NO          |/var/log/php5-fpm.log   |Path to error log file. If it's set to "syslog", log is sent to syslogd instead of being written in a local file.|
|log_level                      |STRING             |NO          |notice                  |Error log level. Possible values: alert, error, warning, notice, debug|
|syslog_facility                |STRING             |NO          |daemon                  |Used to specify what type of program is logging the message|
|syslog_ident                   |STRING             |NO          |php-fpm                 |Prepended to every message. If you have multiple FPM instances running on the same server, you can change the default value which must suit common needs|
|emergency_restart_threshold    |INT                |NO          |0                       |If this number of child processes exit with SIGSEGV or SIGBUS within the time interval set by emergency_restart_interval, then FPM will restart|
|emergency_restart_interval     |TIME(s/m/h/d)      |NO          |0                       |Interval of time used by emergency_restart_interval to determine when a graceful restart will be initiated. This can be useful to work around accidental corruptions in an accelerator's shared memory|
|process_control_timeout        |TIME(s/m/h/d)      |NO          |0                       |Time limit for child processes to wait for a reaction on signals from master. Available units: s(econds), m(inutes), h(ours), or d(ays)|
|process_max                    |INT                |NO          |0                       |The maximum number of processes FPM will fork. This has been design to control the global number of processes when using dynamic PM within a lot of pools|
|process_priority               |INT                |NO          |undef                   |Specify the nice(2) priority to apply to the master process (only if set). The value can vary from -19 (highest priority) to 20 (lower priority). Default value: not set.|
|daemonize                      |BOOLEAN            |NO          |yes                     |Send FPM to background. Set to 'no' to keep FPM in foreground for debugging. |
|rlimit_files                   |INT                |NO          |SYSCTL                  |Set open file descriptor rlimit for the master process. Default value: Set open file descriptor rlimit for the master process.|
|rlimit_core                    |INT                |NO          |0                       |Set max core size rlimit for the master process|
|events.mechanism               |STRING             |NO          |undef                   |Specify the event mechanism FPM will use. The following is available: select, pool, epoll, kqueue (*BSD), port (Solaris).|
|systemd_interval               |INT                |NO          |10                      |When FPM is build with systemd integration, specify the interval, in second, between health report notification to systemd. Set to 0 to disable|

### List of pool directives

Set pool directives with `php_fpm_pools` variable. Format `LIST`

|VARIABLES                      |  TYPES            |REQUIRE     |DEFAULT                 |DESCRIPTION                                        |
|-------------------------------|-------------------|------------|------------------------|---------------------------------------------------|
|name                           |STRING             |**YES**     |                        |Name of pool.|
|user                           |STRING             |NO          |www-data                |Unix user of FPM processes. |
|group                          |STRING             |NO          |{{item.user}}           |Unix group of FPM processes.|
|listen_socket                  |PATH               |NO          |/var/run/php-{{$item.name}}.sock |Socket pour accepter des requêtes FastCGI. '/path/to/unix/socket'. Exclu `listen_tcp`|
|listen_tcp                     |IPv4:PORT          |NO          |undefined               |The TCP address on which to accept FastCGI requests|
|listen_owner                   |STRING             |NO          |www-data                |Set User permissions for unix socket|
|listen_group                   |STRING             |NO          |{{item.listen_owner}}   |Set Group permissions for unix socket|
|listen_mode                    |STRING             |NO          |0660                    |Set Chmod permissions for unix socket|
|listen_allowed_clients         |STRING             |NO          |127.0.0.1               |List of IPv4 addresses of FastCGI clients which are allowed to connect. Use if listen.tcp is defined|
|listen_backlog                 |INT                |NO          |undef                   |Set listen(2) backlog|
|pm                             |STRING             |NO          |dynamic                 |Choose how the process manager will control the number of child processes. Possible values: static, ondemand, dynamic.|
|pm_max_children                |INT                |NO          |50                      |The number of child processes to be created when pm is set to static and the maximum number of child processes to be created when pm is set to dynamic|
|pm_start_servers               |INT                |NO          |5                       |The number of child processes created on startup. Used only when pm is set to dynamic|
|pm_min_spare_servers           |INT                |NO          |5                       |The desired minimum number of idle server processes. Used only when pm is set to dynamic|
|pm_max_spare_servers           |INT                |NO          |35                      |The desired maximum number of idle server processes. Used only when pm is set to dynamic|
|pm_max_requests                |INT                |NO          |200                     |The number of requests each child process should execute before respawning. This can be useful to work around memory leaks in 3rd party libraries|
|pm_status_path                 |STRING             |NO          |/status                 |The URI to view the FPM status page|
|pm_process_idle_timeout        |TIME(s)            |NO          |10s                     ||
|ping_path                      |STRING             |NO          |/ping                   |The ping URI to call the monitoring page of FPM. If this value is not set, no URI will be recognized as a ping page|
|ping_response                  |STRING             |NO          |pong                    |This directive may be used to customize the response to a ping request. The response is formatted as text/plain with a 200 response code|
|request_terminate_timeout      |TIME(s/m/h/d)      |NO          |0                       |The timeout for serving a single request after which the worker process will be killed|
|request_slowlog_timeout        |TIME(s/m/h/d)      |NO          |0                       |The timeout for serving a single request after which a PHP backtrace will be dumped to the 'slowlog' file|
|slowlog                        |PATH               |NO          |undef                   |The log file for slow requests|
|rlimit_files                   |INT                |NO          |SYSCTL                  |Set open file descriptor rlimit for child processes in this pool|
|rlimit_core                    |INT                |NO          |SYSCTL                  |Set max core size rlimit for child processes in this pool|
|chroot                         |PATH               |NO          |undef                   |Chroot to this directory at the start. This value must be defined as an absolute path|
|chdir                          |PATH               |NO          |undef                   |Chdir to this directory at the start. This value must be an absolute path|
|catch_workers_output           |BOOLEAN            |NO          |yes                     |Redirect worker stdout and stderr into main error log. If not set, stdout and stderr will be redirected to /dev/null according to FastCGI specs|
|clear_env                      |BOOLEAN            |NO          |undef                   |Clear environment in FPM workers. Prevents arbitrary environment variables from reaching FPM worker processes by clearing the environment in workers before env vars specified in this pool configuration are added. Since PHP 5.4.27, 5.5.11, and 5.6.0|
|security_limit_extensions      |STRING             |NO          |undef                   |Limits the extensions of the main script FPM will allow to parse. This can prevent configuration mistakes on the web server side|
|php_flag                       |HASHES             |NO          |undef                   |Set a boolean configuration directive|
|php_admin_flag                 |HASHES             |NO          |undef                   |Set a boolean configuration directive can not be overridden|
|php_value                      |HASHES             |NO          |undef                   |Sets the value of the specified directive|
|php_admin_value                |HASHES             |NO          |undef                   |Sets the value of the specified directive can not be overridden|
|env                            |HASHES             |NO          |undef                   |Passing environment variables|

### List of Custom Repository

Set custom repository with `php_repo` variable. Format `LIST`

|VARIABLES                      |  TYPES            |REQUIRE     |DEFAULT                 |DESCRIPTION                                        |
|-------------------------------|-------------------|------------|------------------------|---------------------------------------------------|
|url                            |STRING             |**YES**     |undef                   |repository url|
|key                            |STRING             |NO          |undef                   |GPG Key|
|distribution                   |STRING             |**YES**     |undef                   |Distribution Name (`stable|jessie|wheezy|squeeze`)|
|section                        |STRING             |**YES**     |undef                   |Pinning Section: (`all|main|contrib|...`)|
|pin                            |STRING             |NO          |undef                   |Pin (`pin: 'o=packages.dotdeb.org'`)|
|pin_packages                   |STRING             |NO          |undef                   |Package filter `Regex`|
|pin_priority                   |INT                |NO          |undef                   |Pinning priority|
|description                    |STRING             |**YES**     |undef                   |Description if repository (only EL/CentOS)|


Examples
--------
- [Minimal Quickstart example](examples/quickstart.md)
- [PHP sapi FPM advanced example](examples/php-fpm.md)
- [Custom repository](examples/custom-repository.md)

## Credits

See [Contributeurs](http://gitlab.nexen.net/ansibleroles/awh-php/graphs/master)

## Licence

View [LICENSE](LICENSE) for the software contained in this image.
