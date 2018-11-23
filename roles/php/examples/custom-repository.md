# Example - Custom repository

`php_repo` variable is a **DICT**. The task use the apt 

### Example php 5.6 for Debian Trusty

```yaml
---
php_repo:

  'php_repository':
    url          : "http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu"
    distribution : 'trusty'
    keyserver    : "keyserver.ubuntu.com"
    section      : 'main'
    id           : E5267A6C
    state        : present
    pin          : 'o=ppa.launchpad.net/ondrej/php5-5.6/ubuntu'
    pin_packages : '*'
    pin_priority : '{{ php_pin_priority }}'


```

### Example php 7.0 for Debian Jessie

```yaml

php_repo:

  'php_repository':
    url          : "http://packages.dotdeb.org"
    distribution : 'jessie'
    key          : "https://www.dotdeb.org/dotdeb.gpg"
    section      : all
    id           : 89DF5277
    state        : present
    pin          : 'o=packages.dotdeb.org'
    pin_packages : '*'
    pin_priority : '{{ php_pin_priority }}'


```