# Example - Minimal Quickstart


## Just install php (CLI)

```yaml
---
- hosts: all
  become: true

  roles:
   - awh-php
```

## Just install php (FPM)

```yaml
---
- hosts: all
  become: true

  roles:
   - awh-php
   
  vars:
    php_sapi: 'fpm'
    
```


## Just install php (Apache)

```yaml
---
- hosts: all
  become: true

  roles:
   - awh-php
   
  vars:
    php_sapi: 'apache'
    
```

## Fix your php version

```yaml
---
- hosts: all
  become: true

  roles:
   - awh-php
   
  vars:
    php_version: '7.0.10'
    php_sapi: 'fpm'
    
```