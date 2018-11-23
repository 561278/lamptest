APACHE ![ansible-apache](https://img.shields.io/badge/ansible-apache-ff69b4.svg)
================

[Overview]: #overview
[Role description]: #role-description
[Supported OS]: #supported-os
[Disclaimer]: #disclaimer
[Requirements]: #requirements
[Dependancies]: #dependancies
[Installation]: #installation
[File management]: #file-management
[Handlers]: #handlers
[Tags]: #tags
[Templates]: #templates
[Parameters]: #parameters

[QuickStart]: #quickstart
[Usage]: #usage
[Main configuration]: #main-configuration
[Listeners configuration]: #listeners-configuration
[Include directories configuration]: #include-custom-configuration-directories-in-apache-main-configuration
[Apache modules]: #install-and-configure-apache-modules
[Vhosts configuration]: #vhosts-configuration
[Basic name-based virtual hosts]: #vhosts-configuration
[Vhosts with multiple port and ip binding]: #vhosts-with-multiple-port-and-ip-binding
[Set an priority]: #set-an-priority
[Manage DocumentRoot]: #manage-documentroot
[Protect Directory or Files with htpasswd]: #protect-directory-or-files-with-htpasswd
[Configure ServerAlias]: #configure-serveralias
[Manage Directories]: #manage-directories
[Configure Aliases]: #configure-aliases
[Set an FallbackResource]: #set-an-fallbackresource
[Set several ErrorDocuments]: #set-several-errordocuments
[Creates RewriteRules]: #creates-rewriterules
[Vhosts with SSL]: #vhosts-with-ssl
[Vhosts with custom templates]: #vhosts-with-custom-templates
[Configuring FastCGI servers via mod_fastcgi]: #configure-fastcgi-servers-to-handle-php-files-via-mod_fastcgi
[Configuring FastCGI servers via mod_proxy_fcgi servers]: #configure-fastcgi-servers-to-handle-php-files-via-mod_proxy_fcgi
[Security and Performance]: #security-and-performance
[Block bad User-Agent and IP or Hostname]: #security-and-performance
[Block access to SCM files]: #block-access-to-scm-files
[Block access to DOT files]: #block-access-to-dot-files
[Hostname lookups and DNS considerations]: #hostname-lookups-and-dns-considerations
[Options FollowSymLinks, SymLinksIfOwnerMatch and Index]: #options-followsymlinks-symlinksifownermatch-and-index
[Restrict AllowOverride]: #restrict-allowoverride
[Tuning Apache MPM configuration]: #tuning-apache-mpm-configuration
[Tips]: #tips

[Reference]: #reference
[Apache main configuration]: #apache-main-configuration
[Tasks]: #tasks
[apache_modules]: #apache_modules
[apache_fastcgi]: #apache_fastcgi
[apache_vhosts]: #apache_vhosts


[About this documentation]: #about-this-documentation

[Development]: #development
[Using test-kitchen]: #using-test--kitchen
[Rspec]: #rspec
[Credits]: #credits
[Licence]: #Licence
[References]: #references

[array]: https://docs.ansible.com/ansible/YAMLSyntax.html
[YAML]: http://www.yaml.org/spec/1.2/spec.html
[ANSIBLE]: https://docs.ansible.com/ansible/index.html
[JINJA]: http://jinja.pocoo.org/docs/dev/
[JSON]: http://json.org/
[`AddDefaultCharset`]: https://httpd.apache.org/docs/current/mod/core.html#adddefaultcharset
[`add_listen`]: #add_listen
[AddType]: https://httpd.apache.org/docs/current/mod/mod_mime.html#addtype
[`Alias`]: https://httpd.apache.org/docs/current/mod/mod_alias.html#alias
[`AliasMatch`]: https://httpd.apache.org/docs/current/mod/mod_alias.html#aliasmatch
[aliased servers]: https://httpd.apache.org/docs/current/urlmapping.html
[User-Agent]: http://www.useragentstring.com/pages/useragentstring.php
[Scanners]: http://sectools.org/tag/web-scanners/
[Cyveillance]: https://en.wikipedia.org/wiki/Cyveillance
[`AllowEncodedSlashes`]: https://httpd.apache.org/docs/current/mod/core.html#allowencodedslashes
[HostnameLookups]: https://httpd.apache.org/docs/current/mod/core.html#hostnamelookups
[`default_log_formats`]: #default_log_formats
[`apache_version`]: #apache-version
[`balancer`]: #balancer
[`balancer member`]: #balancer-member
[`fastcgi server`]: #fastcgi-server
[alias`]: #alias
[`auth_cas`]: #auth_cas
[`disk_cache`]: #disk_cache
[`event`]: #event
[`ext_filter`]: #ext_filter
[`geoip`]: #geoip
[`itk`]: #itk
[`ldap`]: #ldap
[`passenger`]: #passenger
[`peruser`]: #peruser
[`prefork`]: #prefork
[`proxy_html`]: #proxy_html
[`security`]: #security
[`shib`]: #shib
[`ssl`]: #mod_ssl
[`status`]: #mod_status
[`worker`]: #mod_worker
[`wsgi`]: #mod_wsgi
[`vhost`]: #vhost
[Apache HTTP Server]: https://httpd.apache.org
[Apache]: https://httpd.apache.org
[Apache modules]: https://httpd.apache.org/docs/current/mod/
[`worker`]: https://httpd.apache.org/docs/current/mpm.html
[certificate revocation list]: https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslcarevocationfile
[certificate revocation list path]: https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslcarevocationpath
[common gateway interface]: https://httpd.apache.org/docs/current/howto/cgi.html
[`confd_dir`]: #confd_dir
[`content`]: #content
[custom error documents]: https://httpd.apache.org/docs/current/custom-error.html
[`custom_fragment`]: #custom_fragment

[`default_modules`]: #default_modules
[`default_ssl_crl`]: #default_ssl_crl
[`default_ssl_crl_path`]: #default_ssl_crl_path
[`default_ssl_vhost`]: #default_ssl_vhost
[`dev_packages`]: #dev_packages
[`directory`]: #directory
[`files`]: #files
[`location`]: #location
[`directories`]: #parameter-directories-for-apachevhost
[`DirectoryIndex`]: https://httpd.apache.org/docs/current/mod/mod_dir.html#directoryindex
[`docroot`]: #docroot
[`docroot_owner`]: #docroot_owner
[`docroot_group`]: #docroot_group
[`DocumentRoot`]: https://httpd.apache.org/docs/current/mod/core.html#documentroot

[`EnableSendfile`]: https://httpd.apache.org/docs/current/mod/core.html#enablesendfile
[enforcing mode]: http://selinuxproject.org/page/Guide/Mode
[`error_log_file`]: #error_log_file
[`error_log_syslog`]: #error_log_syslog
[`error_log_pipe`]: #error_log_pipe
[`ExpiresByType`]: https://httpd.apache.org/docs/current/mod/mod_expires.html#expiresbytype
[`ExtendedStatus`]: https://httpd.apache.org/docs/current/mod/core.html#extendedstatus
[FastCGI]: https://htmlpreview.github.io/?https://github.com/FastCGI-Backups/mod_fastcgi/blob/master/docs/mod_fastcgi.html
[FPM]: https://secure.php.net/manual/en/install.fpm.configuration.php
[FallbackResource]: https://httpd.apache.org/docs/current/mod/mod_dir.html#fallbackresource
[`fallbackresource`]: #fallbackresource
[filter rules]: https://httpd.apache.org/docs/current/filter.html
[`filters`]: #filters
[`ForceType`]: https://httpd.apache.org/docs/current/mod/core.html#forcetype

[GeoIPScanProxyHeaders]: http://dev.maxmind.com/geoip/legacy/mod_geoip2/#Proxy-Related_Directives

[`IncludeOptional`]: https://httpd.apache.org/docs/current/mod/core.html#includeoptional
[`Include`]: https://httpd.apache.org/docs/current/mod/core.html#include
[interval syntax]: https://httpd.apache.org/docs/current/mod/mod_expires.html#AltSyn
[`ip`]: #ip
[`ip_based`]: #ip_based
[IP-based virtual hosts]: https://httpd.apache.org/docs/current/vhosts/ip-based.html

[`KeepAlive`]: https://httpd.apache.org/docs/current/mod/core.html#keepalive
[`KeepAliveTimeout`]: https://httpd.apache.org/docs/current/mod/core.html#keepalivetimeout
[`keepalive` parameter]: #keepalive
[`keepalive_timeout`]: #keepalive_timeout
[`limitreqfieldsize`]: https://httpd.apache.org/docs/current/mod/core.html#limitrequestfieldsize

[`lib`]: #lib
[`lib_path`]: #lib_path
[`Listen`]: https://httpd.apache.org/docs/current/bind.html
[`bind`]: https://httpd.apache.org/docs/current/bind.html
[`ListenBackLog`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#listenbacklog
[`LoadFile`]: https://httpd.apache.org/docs/current/mod/mod_so.html#loadfile
[`LogFormat`]: https://httpd.apache.org/docs/current/mod/mod_log_config.html#logformat
[`logroot`]: #logroot
[Log security]: https://httpd.apache.org/docs/current/logs.html#security
[`MaxConnectionsPerChild`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#maxconnectionsperchild
[`max_keepalive_requests`]: #max_keepalive_requests
[`MaxRequestWorkers`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#maxrequestworkers
[`MaxSpareThreads`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#maxsparethreads
[MIME `content-type`]: https://www.iana.org/assignments/media-types/media-types.xhtml
[`MinSpareThreads`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#minsparethreads
[`mod_alias`]: https://httpd.apache.org/docs/current/mod/mod_alias.html
[`mod_auth_cas`]: https://github.com/Jasig/mod_auth_cas
[`mod_authz`]: https://httpd.apache.org/docs/current/en/mod/mod_authz_core.html
[`mod_auth_kerb`]: http://modauthkerb.sourceforge.net/configure.html
[`mod_authnz_external`]: https://github.com/phokz/mod-auth-external
[`mod_disk_cache`]: https://httpd.apache.org/docs/2.2/mod/mod_disk_cache.html
[`mod_cache_disk`]: https://httpd.apache.org/docs/current/mod/mod_cache_disk.html
[`mod_expires`]: https://httpd.apache.org/docs/current/mod/mod_expires.html
[`mod_deflate`]: https://httpd.apache.org/docs/current/mod/mod_deflate.html
[`mod_ext_filter`]: https://httpd.apache.org/docs/current/mod/mod_ext_filter.html
[`mod_fcgid`]: https://httpd.apache.org/mod_fcgid/mod/mod_fcgid.html
[`mod_fastcgi`]: https://docs.oracle.com/cd/B31017_01/web.1013/q20204/mod_fastcgi.html
[`mod_geoip`]: http://dev.maxmind.com/geoip/legacy/mod_geoip2/
[`mod_info`]: https://httpd.apache.org/docs/current/mod/mod_info.html
[`mod_itk`]: http://mpm-itk.sesse.net/
[`mod_ldap`]: https://httpd.apache.org/docs/2.2/mod/mod_ldap.html
[`mod_mime`]: https://httpd.apache.org/docs/current/mod/mod_mime.html
[`mod_mime_magic`]: https://httpd.apache.org/docs/current/mod/mod_mime_magic.html
[`mod_mpm_event`]: https://httpd.apache.org/docs/current/mod/event.html
[`mod_negotiation`]: https://httpd.apache.org/docs/current/mod/mod_negotiation.html
[`mod_pagespeed`]: https://developers.google.com/speed/pagespeed/module/?hl=en
[`mod_passenger`]: https://www.phusionpassenger.com/library/config/apache/reference/
[`mod_php`]: http://php.net/manual/en/book.apache.php
[`mod_proxy`]: https://httpd.apache.org/docs/current/mod/mod_proxy.html
[`mod_proxy_fcgi`]: https://httpd.apache.org/docs/2.4/en/mod/mod_proxy_fcgi.html
[`mod_proxy_balancer`]: https://httpd.apache.org/docs/current/mod/mod_proxy_balancer.html
[`mod_remoteip`]: https://httpd.apache.org/docs/current/en/mod/mod_remoteip.html
[`mod_reqtimeout`]: https://httpd.apache.org/docs/current/mod/mod_reqtimeout.html
[`mod_rewrite`]: https://httpd.apache.org/docs/current/mod/mod_rewrite.html
[`mod_security`]: https://www.modsecurity.org/
[`mod_ssl`]: https://httpd.apache.org/docs/current/mod/mod_ssl.html
[`mod_status`]: https://httpd.apache.org/docs/current/mod/mod_status.html
[`mod_version`]: https://httpd.apache.org/docs/current/mod/mod_version.html
[`mod_wsgi`]: https://modwsgi.readthedocs.org/en/latest/
[`mpm_module`]: #mpm_module
[multi-processing module]: https://httpd.apache.org/docs/current/mpm.html

[name-based virtual hosts]: https://httpd.apache.org/docs/current/vhosts/name-based.html
[`no_proxy_uris`]: #no_proxy_uris

[`Options`]: https://httpd.apache.org/docs/current/mod/core.html#options

[`path`]: #path
[`Peruser`]: https://www.freebsd.org/cgi/url.cgi?ports/www/apache22-peruser-mpm/pkg-descr
[`port`]: #port
[`priority`]: #apachevhost
[`proxy_dest`]: #proxy_dest
[`proxy_fcgi`]: #proxy_fcgi
[`proxy_dest_match`]: #proxy_dest_match
[`proxy_pass`]: #proxy_pass
[`ProxyPass`]: https://httpd.apache.org/docs/current/mod/mod_proxy.html#proxypass
[`ProxySet`]: https://httpd.apache.org/docs/current/mod/mod_proxy.html#proxyset
[Python]: https://www.python.org/

[Rack]: http://rack.github.io/
[`rack_base_uris`]: #rack_base_uris
[RFC 2616]: https://www.ietf.org/rfc/rfc2616.txt
[`RequestReadTimeout`]: https://httpd.apache.org/docs/current/mod/mod_reqtimeout.html#requestreadtimeout

[`ErrorDocument`]: https://httpd.apache.org/docs/current/custom-error.html
[`ErrorLog`]: https://httpd.apache.org/docs/current/en/mod/core.html#errorlog
[`LogLevel`]: https://httpd.apache.org/docs/current/en/mod/core.html#loglevel
[`CustomLog`]: https://httpd.apache.org/docs/current/mod/mod_log_config.html#customlog
[`ScriptAlias`]: https://httpd.apache.org/docs/current/mod/mod_alias.html#scriptalias
[`ScriptAliasMatch`]: https://httpd.apache.org/docs/current/mod/mod_alias.html#scriptaliasmatch
[`scriptalias`]: #scriptalias
[SELinux]: http://selinuxproject.org/
[`ServerAdmin`]: https://httpd.apache.org/docs/current/mod/core.html#serveradmin
[`serveraliases`]: #serveraliases
[`ServerAlias`]: https://httpd.apache.org/docs/current/en/mod/core.html#serveralias
[`ServerLimit`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#serverlimit
[`ServerName`]: https://httpd.apache.org/docs/current/mod/core.html#servername
[`ServerRoot`]: https://httpd.apache.org/docs/current/mod/core.html#serverroot
[`ServerTokens`]: https://httpd.apache.org/docs/current/mod/core.html#servertokens
[`ServerSignature`]: https://httpd.apache.org/docs/current/mod/core.html#serversignature
[`source`]: #source
[`SSLCARevocationCheck`]: https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslcarevocationcheck
[SSL certificate key file]: https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslcertificatekeyfile
[SSL chain]: https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslcertificatechainfile
[SSL encryption]: https://httpd.apache.org/docs/current/ssl/index.html
[`ssl`]: #ssl
[`ssl_cert`]: #ssl_cert
[`ssl_compression`]: #ssl_compression
[`ssl_key`]: #ssl_key
[`StartServers`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#startservers
[suPHP]: http://www.suphp.org/Home.html
[`suphp_addhandler`]: #suphp_addhandler
[`suphp_configpath`]: #suphp_configpath
[`suphp_engine`]: #suphp_engine

[`ThreadLimit`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#threadlimit
[`ThreadsPerChild`]: https://httpd.apache.org/docs/current/mod/mpm_common.html#threadsperchild
[`TimeOut`]: https://httpd.apache.org/docs/current/mod/core.html#timeout
[`TraceEnable`]: https://httpd.apache.org/docs/current/mod/core.html#traceenable

[`verify_config`]: #verify_config
[`vhost`]: #apache_vhosts
[`vhost_dir`]: #vhost_dir
[`virtual_docroot`]: #virtual_docroot
[`apache_modules`]: #apache_modules

[`apache_server_tokens`]: #apache_server_tokens
[FollowSymLinks]: https://httpd.apache.org/docs/current/mod/core.html#options
[Index]: https://httpd.apache.org/docs/current/mod/core.html#options
[SymLinksIfOwnerMatch]: https://httpd.apache.org/docs/current/mod/core.html#options
[Allowoverride]: https://httpd.apache.org/docs/current/mod/core.html#allowoverride
[Web Server Gateway Interface]: https://www.python.org/dev/peps/pep-3333/#abstract
[`WSGIPythonPath`]: http://modwsgi.readthedocs.org/en/develop/configuration-directives/WSGIPythonPath.html
[`WSGIPythonHome`]: http://modwsgi.readthedocs.org/en/develop/configuration-directives/WSGIPythonHome.html

#### Table of Contents

1. [Overview][Overview]
2. [Role description - What the module does and why it is useful?][Role description]
3. [Supported OS - Supported OS][Supported OS]
4. [Disclaimer - It's not a ansible or apache documentation][Disclaimer]
5. [Requirements - The role requirements][requirements]
6. [Dependancies - The role dependancies][Dependancies]
7. [Installation - How to install from galaxy or github][Installation]
8. [File management - About apache configuration management from ansible-apache][File management]
9. [Handlers - Running operations after notified on several change][Handlers]
10. [Tags - Run a specific part of tasks][tags]
11. [Templates - Modules and vhosts templates][Templates]
12. [Parameters - apache_prefix consideration][Parameters]
13. [QuickStart - A brief introduction of this role usage][Quickstart]
14. [Usage - What is possible to do and how][Usage]
    - [Main configuration - HTTP Server main conf][Main configuration]
    - [Listeners configuration - Ports and address bindings][Listeners configuration]
    - [Include custom configuration directories in apache main configuration][Include directories configuration]
    - [Vhosts configuration - Example for most used modules][Vhosts configuration]
        -  [Basic name-based virtual hosts][]
        -  [Vhosts with multiple port and ip binding][]
        -  [Set an priority][]
        -  [Manage DocumentRoot][]
        -  [Protect Directory or Files with htpasswd][]
        -  [Configure ServerAlias][]
        -  [Manage Directories][]
        -  [Configure Aliases][]
        -  [Set an FallbackResource][]
        -  [Set several ErrorDocuments][]
        -  [Creates RewriteRules][]
        -  [Vhosts with SSL][]
        -  [Vhosts with custom templates][]
    - [Configuring FastCGI servers via mod_fastcgi to handle PHP files][Configuring FastCGI servers via mod_fastcgi]
    - [Configuring FastCGI servers via mod_proxy_fcgi to handle PHP files][Configuring FastCGI servers via mod_proxy_fcgi servers]
    - [Apache modules - Installation and configuration ][Apache modules]
    - [Security and Performance - Secure and tune your server for best performance][Security and Performance]
        - [Block bad User-Agent and IP or Hostname][]
        - [Block access to SCM files][]
        - [Block access to DOT files][]
        - [Hostname lookups and DNS considerations][]
        - [Options FollowSymLinks, SymLinksIfOwnerMatch and Index][]
        - [Restrict AllowOverride][]
        - [Tuning Apache MPM configuration][]
    - [Tips - Save your time][Tips]
15. [Advanced usage - A tour to better understand how this is orchestrated][Reference]
    - [Apache main configuration][]
    - [apache_modules][]
    - [apache_vhosts][]
16. [About this documentation][About this documentation]
17. [Development - Howto contribute][Development]
    - [Using test-kitchen - Create and Converge ][Using test-kitchen]
    - [Rspec - test-kitchen test][Rspec]
18. [Credits][Credits]
19. [Licence][Licence]
20. [References][References]

## Overview

This role manage Apache Server.

## Role description

The apache role installs, configures, and manages the Apache service.

This role manages both the installation and configuration of [Apache HTTP Server]. It provides a streamlined way to install and configure [Apache modules][] and powerfull configuration for virtual hosts.

## Supported OS

  ![Debian](https://img.shields.io/badge/Debian-Jessie|Wheezy|Squeeze-blue.svg)
  ![Ubuntu](https://img.shields.io/badge/Ubuntu-Precise|Trusty-blue.svg)
  ![EL](https://img.shields.io/badge/EL-6.x--7.x-blue.svg)
  ![FreeBSD](https://img.shields.io/badge/FreeBSD-10.x-blue.svg)

## Disclaimer

While every precaution has been taken in the preparation of this documentation, the authors assumes no responsibility for errors or omissions, or for damages in production resulting from the use of the information contained herein.

Also it is important to note that the documentation provided is not meant to replace official documentation of [APACHE][], [ANSIBLE][], [YAML][], [JINJA][] and [JSON][]. So do not waste your time asking questions about them unless you intend to participate in the development and / or documentation.

## Requirements

☕️ OR 🍻

## Dependancies

None

## Installation

##### From Galaxy

```
$ ansible-galaxy install helldorado.apache
```

##### From Github

Set `version` to version you want. Don't use the develop branch.

```yaml
- src: git+ssh://git@github.com:helldorado/ansible-apache.git
  version: origin/stable
  name: apache
```

```
$ ansible-galaxy install -r requirements.yml --force
```

## File management

Configuration files and directories (tree, main file, modules and vhosts configurations...) are managed by this role.

> :warning: Configurations not managed by Ansible and present in those directories will be purged.

All file are set in **read-only** mode and a header is added to avoid modifications in production target by hand.

## Handlers

Handlers | Notified when |Service state|Validate
  ---|---|---|---
  restart apache | modules state or bindings changed|Restarted|```apachectl -t```
  reload apache| vhosts, modules, main are modified|Reloaded|```apachectl -t```

## Tags

Selective execution of tasks.

TAG | DESCRIPTION |EXAMPLES
  ---|---|---
  apache | Run all tasks of this role|```$ ansible-playbook playbooks/apache.yml --tags apache```
  apache_config | Everything related to configuration (no installation)|```$ ansible-playbook playbooks/apache.yml --tags apache_config```
  apache_fastcgi |Configure Fastcgi server|```$ ansible-playbook playbooks/apache.yml --tags apache_fastcgi```
  apache_install |Install Apache MPM|```$ ansible-playbook playbooks/apache.yml --tags apache_install```
  apache_modules |Install and configure modules|```$ ansible-playbook playbooks/apache.yml --tags apache_modules```
  apache_vhosts |Configure vhosts|```$ ansible-playbook playbooks/apache.yml --tags apache_vhosts```

## Templates

The role has been designed to facilitate the use and updates of modules and virtual hosts block. If you do not provide a variable for a template in particular, default variables will be loaded. Please note, some modules have required variables. Cf [Reference](#reference)

## Parameters

All parameters are prefixed by **```apache_```**. To make this documentation more readable, this prefix will not be added to the variable names. However, you must systematically add it in your `playbooks`, `host_vars`, `group_vars` or other variables files.

> :information_source: Parameters in dictionnaries are not prefixed by **```apache_```**

## Quickstart

> :warning: Apache configuration should be fully managed by Ansible, as unmanaged configuration files can cause unexpected failures.

Configure a simple apache service with single virtualhost.

> :information_source: By default, bind **Port** is `*:80` and **MPM** is `worker`.

```yaml
---
- hosts: spyweb
  become: false
  roles:
   - helldorado.apache
  vars:
    apache_mpm: prefork
    apache_vhosts:
      'helldorado.info':
        priority   : '001'
        servername : 'www.helldorado.info'
        serveralias:
          - 'combo.helldorado.info'
          - 'sabrewulf.helldorado.info fulgor.helldorado.info raiden.helldorado.info'
        serveradmin: 'admin@helldorado.info'
        documentroot: '/var/www/helldorado'
```

> :information_source: Be carreful, using default configuration in production is not recommended. Please read section [Reference](#reference) for templates variables for modules and vhosts.

## Usage

By default, apt will update its cache at every call. If, for any reason, you don't want it to, run your playbook with `-e update_cache=false`.

### **Main configuration**

The main configuration allow you to set overall configuration for the HTTP Server. And how it abstracts other configuration from other sections.

- Set the [`ServerTokens`][] via [`apache_server_tokens`][] which determine the `Server` response header sent back to clients, including a description of the server's OS-type as well as information about compiled-in modules.

```yaml
apache_server_tokens: 'Prod'
```

- Set the [`ServerSignature`][] via [`apache_server_signature`][] wich allows the configuration of a trailing footer line under server-generated documents (error messages, mod_proxy, ftp directory listings, mod_info output, ...).

```yaml
apache_server_signature: 'Off'
```

- Set the main server name with the server **`fqdn`**.

```yaml
apache_servername: {{ ansible_fqdn }}
```

- Set the server [`Timeout`][] via [`apache_timeout`][] wich defines the time period in seconds Apache will wait for I/O in various circumstances

```yaml
apache_timeout: 100
```

- Set the server [`Keepalive`][] via [`apache_keepalive`][] which determines whether to enable persistent TCP connections with the KeepAlive directive.

```yaml
apache_keepalive: 'On'
```

- Set the main [`LogFormat`][] via [`apache_default_log_format`][]

```yaml
apache_default_log_formats:
   combined  : '"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined'
   common    : '"%h %l %u %t \"%r\" %>s %b" common'
   referer   : '"%{Referer}i -> %U" referer'
   agent     : '"%{User-agent}i" agent'
   forwarded : '"%{X-Forwarded-For}i %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"" forwarded'
   syslog    : '"%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\" %b %D %T %P %v:%p" syslog'
```

- If you need [`CustomLog`][] format

```yaml
apache_custom_log_format:
  customlog: "|/usr/bin/cronolog /var/log/apache2/%m/error.%Y.%m.%d.log"
  errorlog: "|/usr/bin/cronolog /var/log/apache2/%m/access.%Y.%m.%d.log"
  expr: "combined" *
```
'combined' is the default then it is optional to precise it.


## Listeners configuration
Manage listen directives that define the default Apache server's or a virtual host's listening address and port.

**```bind```**

Sets [`Listen`][] which apache bind to. **Valid options:** List of `IP:PORT`. such as

```yaml
apache_bind:
  - '*:80'
  - '10.0.10.11:82'
  - '*:8080'
  - '*:443'
  - '*:8443 https'
```

**OR** (I prefere this format)

```yaml
apache_bind: ['*:80', '*:443', '10.0.10.11:82', '*:8080', '*:8443 https']
```

> :warning: Ensure that there is no service binding to any **```IP:PORT```** your have defined, otherwise apache won't start.

## Include custom configuration directories in apache main configuration

```yaml
apache_include:
  - path: '/etc/apache2/custom_config'
  - path: '/etc/apache2/awh'
  - path: '/var/www/client1_vhosts'
    user : client1
    group: client1
  - path: '/var/www/client2_vhosts'
    user : client2
    group: client2
```

> :warning: Ensure users and groups associated with directories exists before running the playbook to avoid unexpected failures when creating them. Please see the [awh-users role](https://git.alterway.fr/ansibleroles/awh-users)
> :information_source: If path match /etc/apache2/ the `owner` and `group` will be always `root` for security reasons. If `user` and `group` not provided it take the `apache_user` and `apache_group` default value. Also note, all embeded apache path setted here will be dropped from dict before any execution.

## **Vhosts configuration**

> :information_source: See the [`vhost`][] templates reference for a list of all virtual host parameters.

To configure a basic [name-based virtual hosts][], specify the [`bind`][], the [`servername`][] and [`documentroot`][] parameters in the `apache_vhosts` dictionnary. If `servername` is not defined, it takes the dict's key. Know about **`item.key`** => [looping-over-hashes](ttps://docs.ansible.com/ansible/playbooks_loops.html#looping-over-hashes)

```yaml
apache_vhosts:
  'helldorado.info':
    documentroot: '/var/www/helldorado'
```

#### **Vhosts with multiple port and ip binding**

```yaml
apache_vhosts:
  'helldorado.info':
    bind : ['10.0.10.11:80', '10.0.10.12:82', '10.0.10.13:83']
```

#### **Set a priority**
> :information_source: Apache processes virtual hosts in alphabetical order.

use the parameter [`priority`][] to prefix the vhost configuration's filename with a number.

```yaml
apache_vhosts:
  'helldorado.info':
    priority      : '010'
```

#### **Manage DocumentRoot**

  - **Set a [`documentroot`][] for the virtual host**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        priority      : '010'
        bind          : ['*:82']
        documentroot  : '/var/www/helldorado'
    ```

  - **Set  User and Group for [`DocumentRoot`][]**

    To set [`user`][] and [`group`][] ownership for the [`DocumentRoot`][], use the [`path`][], [`user`][] and [`group`][] parameters.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        priority      : '010'
        bind          : '*:82'
        documentroot  :
          path  : '/var/www/helldorado'
          user  : wwwh-data
          group : www-data
    ```

  - **Don't create the directory on system**

    If the directory is managed by custom deploiement system, set [`create`][] parameter to `false`.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        priority      : '010'
        bind          : '*:82'
        documentroot  :
          path  : '/var/www/helldorado'
          create: no
    ```
  - **Create DocumentRoot based on a symlink**

    To create a [`DocumentRoot`][] that points to another path, set [`link`](http://man7.org/linux/man-pages/man2/link.2.html) parameter.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        priority      : '010'
        bind          : '*:82'
        documentroot  :
          path: /var/www/helldorado-ssl
          link: /var/www/helldorado
    ```

  - **Copy data to documentroot**

    * **Copy data from the manager node**

        To copy data from manager node to inventory host, set `data` parameter, set the `provider` to **`copy`** and [`source`][].

        ```yaml
        apache_vhosts:
          'helldorado.info':
            priority      : '010'
            bind          : '*:82'
            documentroot  :
              path  : '/var/www/helldorado'
              user  : wwwh-data
              group : www-data
              data:
                provider: copy
                source  : /var/websites/helldorado
        ```

    * **Create file with content**

        To create a file with inline content, set `data` parameter, set the `provider` to **`content`** and `dest`. `dest` is relative to the [`DocumentRoot`][].

        ```yaml
        apache_vhosts:
          'helldorado.info':
            priority      : '010'
            bind          : '*:82'
            documentroot  :
              path  : '/var/www/helldorado'
              user  : www-data
              group : www-data
              data:
                data:
                provider: content
                content : |
                  # Show phpinfo page
                  <?php phpinfo(); ?>
                  ###
                dest: index.php
        ```

        > :information_source: **`dest`** is required. The pipe **`|`** denotes a multiline scalar block in YAML, so newlines are preserved in the resulting configuration file output.

    * **Copy data from a git repository**

        To fetch data from a git repository, set `data` parameter, set the `provider` to **`git`** and `repo`. For more info about full paramters, see `data`.

        ```yaml
        apache_vhosts:
          'helldorado.info':
            priority      : '010'
            bind          : '*:82'
            documentroot  :
              path  : '/var/www/helldorado'
              user  : wwwh-data
              group : www-data
              data:
                provider : git
                repo     : https://github.com/WordPress/WordPress.git
                version  : master
                bare     : no
                update   : no
        ```
        > :information_source: [`version`](https://git-scm.com/book/it/v2/Git-Tools-Revision-Selection) can be the full **40-character SHA-1** hash, the literal string **HEAD**, a **branch** name, or a **tag** name.

        > :information_source: If you are using a protected repository, pass login and password in the repository uri in the form **`https://username:password@github.com/username/gitrepo.git`**

        > :warning: Keep sensitive data such as passwords or keys in encrypted files, rather than as plaintext in your playbooks host_vars, group_vars by vault files. For more info => [https://docs.ansible.com/ansible/playbooks_vault.html](http://mdp.tylingsoft.com/).


#### **Configure ServerAlias**

Set [`serveraliases`][] wich create a [`ServerAlias`][] for the virtual host.

```yaml
apache_vhosts:
  'helldorado.info':
    priority      : '010'
    serveraliases: ['spynal.helldorado.info' , 'sabrewulf.helldorado.info fulgor.helldorado.info']
```

#### **Manage directories**

Create [`Directory`][], [`Files`][] and [`Location`][] directive blocks via array of hashes for the virtual host with the [`directories`][] parameter. **Valid options:** A list of hashes. such as:

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path       : '/var/www/helldorado/secret'
        provider   : 'files'
        deny       : ['from all']
        allow      : ['172.0.1.0/32']
      - path       : '/var/www/helldorado/streams'
        allowoverride : ['AuthConfig', 'Indexes']
```
#### **Protect Directory or Files with htpasswd**

- **Create htpasswd user**

```yaml
apache_htpasswd:
  - name: 'helldorado'
    path : '/etc/apache2/.helldorado_htpasswd'
    users:
      - username: 'hell'
        password: 'VrJQH7FenkJHUnH3fOvhMxiS2Q'
      - username: 'helladmin'
        password: 'BibyodTadgiamarWed8'
  - name: 'grafana-helldorado'
    users:
      - username: 'client1'
        password: 'rTicCNc9368YU'
      - username: 'client2'
        password: 'CebMonUdew'
```

- **Protect directory with htpasswd and ensure only valid user can access the resource.**

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path               : '/var/www/helldorado/source_files'
        auth_type          : 'basic'
        auth_name          : 'Restricted content'
        auth_basic_provider: 'file'
        auth_user_file     : '/etc/apache2/.helldorado_htpasswd'
        auth_require       : 'valid-user'
```

- **Sets a Require directive as per the Apache [mod_authz][] via [require](#require) directives**


```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path   : '/var/www/helldorado/source_files'
        require: ['not ip 38.100.19.8/29', 'not ip 65.222.185.72', 'not group locked']
```

> :information_source: When multiple **Require** directives are used in a single configuration section and are not contained in another authorization directive like <RequireAll>, they are implicitly contained within a <RequireAny> directive. Thus the first one to authorize a user authorizes the entire request, and subsequent Require directives are ignored.

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path   : '/var/www/helldorado/source_files'
        require:
          - enclose: all
            requires: ['method GET POST OPTIONS', 'ldap-group cn=Administrators,o=awh', 'ldap-attribute o="st"']
          - enclose: any
            requires: ['group admin', 'group wheel', 'group god']
```

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path   : '/var/www/helldorado/source_files'
        require:
          - enclose: none
            requires: ['group temps', 'ldap-group cn=Temporary Employees,o=Alterway']
```

> :information_source: If no **`require`** is set, it will default to **`Require all granted`**. Please see [require](#require) for more info.

> :information_source: `enclose`: is the scope of directives. **Valid options:** `all|any|none`. Other values are silently ignored.


#### **Configure Aliases**

Use [`aliases`](#aliases) parameter to manage [`mod_alias`][] and set [`Alias`][], [`AliasMatch`][], [`ScriptAlias`][] or [`ScriptAliasMatch`][] directives. **Valid options:** A list of hashes. such as:

```yaml
apache_vhosts:
  'helldorado.info':
    aliases:
      - aliasmatch: '^/image/(.*)\.jpg$'
        path: '/files/jpg.images/$1.jpg'
      - alias: '/image'
        path: '/ftp/pub/image'
      - scriptaliasmatch: '^/cgi-bin(.*)'
        path: '/usr/local/share/cgi-bin$1'
      - scriptalias: '/nagios/cgi-bin/'
        path: '/usr/lib/nagios/cgi-bin/'
      - alias: '/nagios'
        path: '/usr/share/nagios/html'
```

Can also writed like:

```yaml
apache_vhosts:
  aliases:
    - path: '/files/jpg.images/$1.jpg'
      aliasmatch: '^/image/(.*)\.jpg$'
    - path: '/ftp/pub/image'
      alias: '/image'
    - path: '/usr/local/share/cgi-bin$1'
      scriptaliasmatch: '^/cgi-bin(.*)'
    - path: '/usr/lib/nagios/cgi-bin/'
      scriptalias: '/nagios/cgi-bin/'
    - path: '/usr/share/nagios/html'
      alias: '/nagios'
```


#### **Configure Logging (Error and Access)**

  - **Send [`Errorlog`][] and [`CustomLog`][] with default [`LogFormat`][]**

    To send  [`Errorlog`][] to `/var/log/${APACHE_LOG_DIR}/${ServerName}-error.log` and [`CustomLog`][] file to  `/var/log/${APACHE_LOG_DIR}/${ServerName}-access.log` set [`error_log`](#error_log) and [`access_log`](access_log) with empty values.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        error_log:
        access_log:
    ```

  - **Set [`LogLevel`][] and send [`Errorlog`][] to custom destination**

    Use [`level`][] and [`dest`][] parameters.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        error_log:
          level: crit
          dest : '/var/log/apache2/hell-critical.log'
    ```

  - **Set [`owner`][] and [`group`][] and send [`Errorlog`][] and [`CustomLog`][] to custom destination**

    Use [`owner`][] and [`group`][] parameters.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        error_log:
          owner: user1
          group: group1
          dest : '/var/log/apache2/error-log/hell-error.log'
        access_log:
          owner: user1
          group: group1
          dest : '/var/log/apache2/access-log/hell-access.log'
     ```

  - **Send [`CustomLog`][] to custom destination with using predefined [`LogFormat`][]**

    Use [`format`][`LogFormat`] and `dest` parameters. Please see [`default_log_formats`][]

    ```yaml
    apache_vhosts:
      'helldorado.info':
        access_log:
          format: forwarded
          dest  : '/var/log/apache2/helldorado-access.log'
    ```

  - **Set [`LogFormat`][] and send [`CustomLog`][] to custom destination**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        access_log:
          format: "'%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\" %b %D %T %P %V:%p' x_forwarded_log"
          dest  : '/var/log/apache2/helldorado-access.log'
    ```

  - **Send [`Errorlog`][] and [`CustomLog`][] to custom destination with a pipe**

    Use [`pipe`](#https://httpd.apache.org/docs/2.4/en/logs.html#piped) parameter.

    ```yaml
    apache_vhosts:
      'helldorado.info':
        error_log :
          pipe  : '|/usr/bin/cronolog --symlink=/var/log/apache2/error.log /var/log/apache2/%m/error.%Y.%m.%d.log'
        access_log:
          format: combined
          pipe  : '|/usr/bin/cronolog --symlink=/var/log/apache2/access.log /var/log/apache2/%m/access.%Y.%m.%d.log" combined'
    ```

> :information_source: **`${APACHE_LOG_DIR}`** is OS related, **`${ServerName}`** is the **`servername`** defined for this virtual host. If **`severname`** is not defined, it takes the dictionary's key

#### **Set a FallbackResource**

> :information_source: only compatible with version **2.4** or above

Use [`fallbackresource`][] to set a handler for any URL that doesn't map to anything in your filesystem, and would otherwise return **`HTTP 404`** (Not Found)

```yaml
apache_vhosts:
  'helldorado.info':
    priority      : '010'
    documentroot  : '/var/www/helldorado'
    fallbackresource: /index.html
```

#### **Set several ErrorDocuments**

[`error_documents`](#error_documents) can be used to override the [`ErrorDocument`][] settings for this virtual host. **Valid options:** A list of hashes. such as:

```yaml
apache_vhosts:
  'helldorado.info':
    error_documents:
      - error_code: '503'
        document: '/var/www/helldorado/503.html'
      - error_code: '404'
        document: 'http://helldorado.info/missing/404.html'
```

#### **Creates RewriteRules**

Use [`rewrites`](#rewrites) parameter to set [`RewriteRules`](https://httpd.apache.org/docs/trunk/en/rewrite/intro.html) via [`mod_rewrite`] in global vhosts or in scope of directives such as Directory.

  - **Add a rewrite rule in a virtual host scope**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        rewrites:
          - comment: 'Lynx or Mozilla v1/2'
            cond: ['%{HTTP_USER_AGENT} ^Lynx/ [OR]', '%{HTTP_USER_AGENT} ^Mozilla/[12]']
            rule: ['^index\.html$ welcome.html']
          - comment: 'Internet Explorer'
             cond: ['%{HTTP_USER_AGENT} ^MSIE']
             rule: ['^index\.html$ /index.IE.html [L]']
          - comment: 'Apps base'
             base: /apps/
             rule: ['^index\.cgi$ index.php', '^index\.html$ index.php', '^index\.asp$ index.html']
    ```

  - **Add a rewrite rule in a directory scope**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        directories:
          - path          : '/var/www/helldorado/streams'
            allowoverride : ['AuthConfig', 'Indexes']
            rewrites:
              - comment : 'Lynx or Mozilla v1/2'
                cond    : ['%{HTTP_USER_AGENT} ^Lynx/ [OR]', '%{HTTP_USER_AGENT} ^Mozilla/[12]']
                rule    : ['^index\.html$ welcome.html']
          - path          : '^/dev'
            provider      : 'directory'
            allowoverride : ['FileInfo', 'Indexes']
            rewrites:
              - comment : 'Rewrite to lower case'
                cond    : ['%{REQUEST_URI} [A-Z]']
                map     : ['lc int:tolower']
                rule    : ['(.*) ${lc:$1} [R=301,L]']
              - comment : 'Internet Explorer'
                cond    : ['%{HTTP_USER_AGENT} ^MSIE']
                rule    : ['^index\.html$ /index.IE.html [L]']
    ```

#### **Vhosts with SSL**

  - **Configure a virtual host to use SSL encryption**

    To configure a virtual host to use SSL encryption, set the [`ssl`][] parameter. You must also need to set `cert` and `key` parameters.

    > :information_source: bind in virtual hosts do not open a port. If you want a specific port for a vhost, please add this port in apache_bind to configure listen in `ports.conf`.

    ```yaml
    apache_vhosts:
      'helldorado.info-ssl':
        servername: helldorado.info
        bind:     : ['10.0.1.11:443']
        ssl:
          cert    :    '/etc/ssl/apache/www.helldorado.info.cert'
          key     :    '/etc/ssl/apache/www.helldorado.info.key'
    ```

  - **Push certificates `cert`, `key` from ansible manager node to target node**

    ```yaml
    apache_vhosts:
      'helldorado.info-ssl':
        servername: helldorado.info
        bind:     : ['10.0.1.11:443']
        ssl:
          certs_dir : '/etc/apache2/certs'
          cert      : '/etc/ssl/apache/www.helldorado.info.cert'
          key       : '/etc/ssl/apache/www.helldorado.info.key'
          ssl_src   : 'data/apache/certs/'
    ```

    > :warning: For security reasons, please make sure the `ssl_src` dir is only readable by root. It can be a relative or absolute path.

  - **Use a self-signed certificate by setting the [`autosinged`][] parameter.**

    ```yaml
    apache_vhosts:
      'helldorado.info-ssl':
        servername: helldorado.info
        bind:     : ['10.0.1.11:443']
        ssl       :
          certs_dir     : '/etc/apache2/certs'
          autosigned:
             subject    :'/C=FR/ST=PARIS/L=Paris/O=HELLDORADO/OU=DEVOPS/CN=helldorado.info'
             days       : 365
             extensions : v3_ca
             bit        : 4096
    ```

  - **Redirect unencrypted connections to SSL**
    To redirect unencrypted connection to SSL, declare in the `apache_vhost` dictionnary and redirect unencrypted requests to the virtual host with SSL enabled:**

    ``` yaml
    apache_vhosts:
      'helldorado.info':
        priority: '010'
        redirect: [{source: '/', destination: 'https://secure.helldorado.info/', status: 'permanent'}]

      'helldorado.info-ssl':
        priority: '010'
        servername: helldorado.info
        bind: ['*:443']
        ssl:
          certs_dir : '/etc/apache2/certs'
          cert      : '/etc/ssl/apache/www.helldorado.info.cert'
          key       : '/etc/ssl/apache/www.helldorado.info.key'
          ssl_src   : 'data/apache/certs/'
    ```

#### **Vhosts with custom templates**

- **Sets an global and default template for all vhosts**

```yaml
apache_vhosts_template: 'data/apache/default/vhosts.j2'
```

For exemple:

```jinja
{% for ban_line in apache_ansible_managed -%}
{{ ban_line }}
{% endfor -%}
<VirtualHost {{ apache_defaultvhost_listen }}:{{ apache_defaultvhost_port }}>
    DocumentRoot {{ item.doc_root }}

    <Directory {{ item.doc_root }}>
                DirectoryIndex index.php
                Options -Indexes
                AllowOverride None
                Require all granted
    </Directory>
</VirtualHost>
```

> :information_source: The default template will be used instead using all options given by this role.

- **Sets an template for only one vhosts**

```yaml
apache_vhosts:
  'helldorado.info':
    priority                          : '010'
    apache_defaultvhost_listen        : 127.0.0.1
    apache_defaultvhost_port          : 82
    docroot  : '/var/www/helldorado'
   'nicolas.ber':
      template: 'data/apache/nicolas/vhosts.j2'
      docroot: /var/www/nico
```

> :information_source: If `apache_vhosts_template` is defined, in the above example, the vhosts `helldorado.info` will use  `'data/apache/default/vhosts.j2'` template and the vhosts `nicolas.ber` will use the specified template via the var `template` in that scope `'data/apache/nicolas/vhosts.j2'`.

> :warning: If you use custom template some fonctionnality offer by this role is not usable.

#### **Configure FastCGI servers to handle PHP files via [`mod_fastcgi`][]**

  > :warning: On Debian Stretch consider using [`proxy_fcgi`][]. See how below. This module is enabled by **default** on Stretch. It is possible to enabled it on Jessie too.

  - **Define a [FastCGI][] server at socket **`/var/run/php5-fpm.sock`** to handle PHP requests and set a [FPM][] status and ping path.**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        fastcgi:
          server: /fcgi-pool-helldorado
          socket: /var/run/php5-fpm.sock
          fpm:
            name   : hell
            ping   : fpm-ping
            status : fpm-status
    ```

    > :information_source: the `server` is a virtual path and is not required.

  - **Define a [FastCGI][] server that send query to **`127.0.0.1`** (localhost) on port **`9000`** to handle PHP requests, set `pass-header`, `idle-timeout` and set a [FPM][] status and ping path.**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        fastcgi:
          server     : /fcgi-pool-helldorado
          host       : '127.0.0.1:9000'
          timeout    : 60
          pass_header: 'Authorization'
          fpm        :
            name   : hell
            ping   : fpm-ping
            status : fpm-status
    ```

#### **Configure FastCGI servers to handle PHP files via [`mod_proxy_fcgi`][]**

  - **Define a [FastCGI][] server at socket **`/var/run/php-fpm.sock`** to handle PHP requests.**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        proxy_fcgi:
          path: '".+\.ph(ar|p|tml)$"'
          socket: /var/run/php5-fpm.sock
    ```

  - **Define a [FastCGI][] server that send query to **`127.0.0.1`** (localhost) on port **`9000`** to handle PHP requests, set `pass-header` and  `enablereuse`.**

    ```yaml
    apache_vhosts:
      'helldorado.info':
        proxy_fcgi:
          path        : '".+\.ph(ar|p|tml)$"'
          host        : '127.0.0.1:9000'
          enable_reuse: 'on'
          pass_header : '^Authorization$ "(.+)" HTTP_AUTHORIZATION=$1'
    ```

    > :information_source: `path`, `enable_reuse`, `pass_header` are not required and have default values. See [`proxy_fcgi`][]
    > `socket` or `host` are required and is mutualy exclusive.

## Apache modules installation

#### **Install and configure modules (conf and load).**

Use [`apache_modules`][] dict. Most module parameters have default values and don't require configuration.

> :information_source: Using default configuration in production is not recommended. Read the templates variables for modules and vhosts below in section [Reference](#reference)

  - **Install modules**

    ```yaml
    apache_modules:
      expires:
      deflate:
      rewrite:
    ```

  - **Desactivate modules**

    ```yaml
    apache_modules:
      ssl          :
        module_state: disabled
      socache_shmcb:
        module_state: disabled
    ```

#### Install, configure and load a modules.

  - **Configure mpm [`worker`][]**

    ```yaml
    apache_modules:
      worker:
        startservers        : 20
        maxclients          : 150
        minsparethreads     : 25
        maxsparethreads     : 75
        threadsperchild     : 25
        maxrequestsperchild : 0
        serverlimit         : 25
        threadlimit         : 64
        listenbacklog       : 511
    ```

  - **Configure [`mod_status`][] modules**

    ```yaml
    apache_modules:
      status:
        allow_from      : ['10.0.1.51 10.0.1.52', '10.10.1.0/28']
        extended_status : 'On'
    ```

  - **Configure CAS AUTH via [`mod_auth_cas`][]**

    ```yaml
    apache_modules:
      auth_cas:
        login_url    :  'https://helldorado.info/cas/login'
        validate_url :  'https://helldorado.info/cas/Validate'
    ```

  - **Configure [`mod_remoteip`] to replaces the original client IP address for the connection with the useragent IP address list presented by a proxies or a load balancer via the request headers**

    ```yaml
    apache_modules:
      remoteip:
        proxy_ips        : ['10.0.1.16', '10.0.1.17']
        trusted_proxy_ip : ['10.0.1.0/28' ]
        header           : 'X-Forwarded-For'
    ```

  - **Install and configure [`mod_fastcgi`][].**

    > :information_source: Do not set here a fastcgi server configuration. Do it in the vhost configuration.

    ```yaml
    apache_modules:
      fastcgi:
        lib_path: '/var/lib/apache2/fastcgi'
    ```

  - **Install and configure [`mod_ssl`][]**

    ```yaml
    apache_modules:
      ssl:
        random_seed_bytes  : 512
        pass_phrase_dialog : 'builtin'
        compression        : 'Off'
        cipher             : 'HIGH:MEDIUM:!aNULL:!MD5:!RC4'
    ```

## Security and performance

#### **Block bad User-Agent and IP or Hostname**

By default some rules are provided for blocking bad bots. You can also add your custom rules by providing **user-agent** (**full** or **regex**), **IP** (**CIDR** supported) and **hostname**

> :warning: Using **`hostname`** resolution is a bad idea for performance and you will pay for two DNS lookups (a reverse, followed by a forward lookup to make sure that the reverse is not being spoofed). ==Note you need to pass [HostnameLookups][] to **`On`** if you really want to use it.==

  - **[Scanners][] to be blocked**

      ```yaml
      apache_badbot:
        scanners :
          - 'sqlmap'
          - 'Acunetix'
          - 'FHscan'
          - 'Nikto'
      ```
  - **Adding list of [User-Agent][]

      ```yaml
      apache_badbot:
        useragent:
          - '^HTTrack'
          - '^Express\ WebPictures'
      ```

  - **Allowing [User-Agent] defined in  [User-Agent default] list** (cf: list of default `User-Agent` is available in `defaults/main.yml`)

      ```yaml
      apache_badbot:
        useragent_allowed:
          - "Aboundex"
          - "80legs"
          - "ZmEu"
          - "^Zyborg"
      ```

  - **Adding list of IP and host to be blocked**

      ```yaml
      apache_badbot:
        ip   : ['38.100.19.8/29', '65.213.208.128/27', '65.222.185.72']
        host : ['moreidiots.example', 'phishers.example.com']
      ```

  - **Block [Cyveillance][]**

      ```yaml
      apache_badbot:
        cyveillance: true
      ```

 > :information_source: Blocking web crawler by IP address will not work correctly. Due to the distributed nature of infrastructure, IP addresses constantly change. It is strongly recommended you don't try to block web crawlers by IP address, as you'll most likely spend several hours of futile effort and be in a very bad mood at the end of it. The best way to save you time and frustration by using using [User-Agent] in here or in per vhost with [robots.txt](http://www.robotstxt.org/robotstxt.html)

#### **Block access to SCM files**

By default some rules are provided for blocking access to SCM files like **`*.git`, `*.svn`, `*.bzr`** . You can also add your custom scm by providing the extensions without the **'.'** such as

```yaml
apache_block:
  scm: ['svn', 'git', 'bzr']
```

#### **Block access to DOT files**

By default some rules are provided for blocking access to sensitive dot files like **`*.bak`, `*.config`, `*.sql`, `*.ini`, `*.log`, `*.sh`, `*.inc`, `*.swp`** . You can also add your custom dot files by providing the extensions without the **'.'** such as

```yaml
apache_block:
  dot: ['cfg', 'yaml', 'yml', 'bz2', 'tar', 'gz']
```

#### **Hostname lookups and DNS considerations**

While [HostnameLookups][] defaults to `Off`, it's possible to scope the directives, such as in  [`Directory`][], [`Files`][], and [`Location`][] to ensure DNS lookups are only performed on requests matching a criteria.

  - **Enable [HostnameLookups][] for some extensions**

      ```yaml
      apache_vhosts:
        'helldorado.info':
          directories:
            - path            : '\.(html|xhtml)$'
              provider        : 'files'
              extra_parameters: 'HostnameLookups On'
      ```

  - **Enable [HostnameLookups][] and deny from search engine to access development environnement.**

      ```yaml
      apache_vhosts:
        'helldorado.info':
          directories:
            - path            : '^/dev'
              provider        : 'directory'
              require         : ['all granted', 'google.com', 'bing.com', 'microsoft.com']
              extra_parameters: 'HostnameLookups On'
      ```

      ```yaml
      apache_vhosts:
        'dev.helldorado.info':
          priority      : '010'
          bind          : ['*:82']
          documentroot  : '/var/www/helldorado-dev/'
          directories:
            - path            : '/var/www/helldorado-dev/'
              provider        : 'directory'
              require         : ['all granted', 'google.com', 'bing.com', 'microsoft.com']
              extra_parameters: 'HostnameLookups On'
      ```

#### **Options [FollowSymLinks][], [SymLinksIfOwnerMatch][] and [Index][]**

While [`Options`] defaults to `FollowSymLinks`, it's possible to scope the directives in  [`Directory`][]. Be carreful, if you add `SymLinksIfOwnerMatch` in [`Options`], Apache will need to issue extra system calls to check up on symlinks. Apache will perform [lstat(2)](http://linux.die.net/man/2/lstat) in parent directory and subdirectory. The results of these `lstats` are never cached, so they will occur on every single request. If you really desire the symlinks security checking, you can do something like this:

 ```yaml
 apache_vhosts:
   'helldorado.info':
     documentroot  : '/var/www/helldorado'
     directories:
       - path     : '/'
         options  : ['FollowSymLinks']
       - path     : '/var/www/helldorado'
         options  : ['-FollowSymLinks', '+SymLinksIfOwnerMatch']
 ```

> :information_source: For highest performance, and no symlink protection, set **`FollowSymLinks`** everywhere, and never set **`SymLinksIfOwnerMatch`**.

#### **Restrict [AllowOverride][]**

[AllowOverride][] defaults to `None` to prevent Apache to attempt to open [.htaccess](https://httpd.apache.org/docs/current/howto/htaccess.html) in all directory and subdirectory. It's possible to scope the directives in  [`Directory`][].

```yaml
apache_vhosts:
  'helldorado.info':
    documentroot  : '/var/www/helldorado'
    directories:
      - path            : '/var/www/helldorado'
        allowoverride   : ['FileInfo', 'Indexes']
```

#### **Tuning [Apache MPM](https://httpd.apache.org/docs/current/mpm.html) configuration**

When installing Apache, you must choose a MPM to use. It defaults to **`worker`**. The MPM choice can affect the speed and scalability of the httpd instance. Please consider tuning your MPM for best performance.

> :warning: Be carreful, using default configuration in production is not recommended. And the below configurations is only to explain how you can configure your MPM.

  - [MPM worker](https://httpd.apache.org/docs/current/mod/worker.html)

    The [`worker`][] MPM uses multiple child processes with many threads each. Each thread handles one connection at a time. Worker generally is a good choice for high-traffic servers because it has a smaller memory footprint than the prefork MPM.

    ```yaml
    apache_modules:
      worker:
        startservers        : 20
        maxclients          : 150
        minsparethreads     : 25
        maxsparethreads     : 75
        threadsperchild     : 25
        maxrequestsperchild : 0
        serverlimit         : 25
        threadlimit         : 64
        listenbacklog       : 511
    ```

  - [MPM event](https://httpd.apache.org/docs/current/mod/event.html)

    The [`event`][] MPM is threaded like the Worker MPM, but is designed to allow more requests to be served simultaneously by passing off some processing work to supporting threads, freeing up the main threads to work on new requests.

    ```yaml
    apache_modules:
      event:
        startservers        : 20
        maxrequestworkers   : 150
    ```

  - [MPM prefork](https://httpd.apache.org/docs/current/mod/prefork.html)

    The [`prefork`][] MPM uses multiple child processes with one thread each. Each process handles one connection at a time. On many systems, prefork is comparable in speed to worker, but it uses more memory. Prefork's threadless design has advantages over worker in some situations: it can be used with non-thread-safe third-party modules, and it is easier to debug on platforms with poor thread debugging support.

    ```yaml
    apache_modules:
      prefork:
        startservers        : 20
        maxclients          : 150
        minspareservers     : 25
        maxspareservers     : 75
        serverlimit         : 25
        listenbacklog       : 511
    ```

  - [MPM ITK](http://mpm-itk.sesse.net/)

    The [`itk`][] MPM is based on the traditional prefork MPM, which means it's non-threaded; in short, this means you can run non-thread-aware code (like many PHP extensions) without problems. On the other hand, you lose out to any performance benefit you'd get with threads, of course; you'd have to decide for yourself if that's worth it or not. You will also take an additional performance hit over prefork, since there's an extra fork per request.

    ```yaml
    apache_modules:
      itk:
        startservers        : 20
        maxclients          : 150
        minspareservers     : 25
        maxspareservers     : 75
        serverlimit         : 25
        listenbacklog       : 511
    ```

  - [MPM peruser](http://mpm-itk.sesse.net/)

    The [`peruser`][] MPM is based on metuxmpm, a working implementation of the perchild MPM. The fundamental concept behind all of them is to run each apache child process as its own user and group, each handling its own set of virtual hosts. Peruser and recent metuxmpm releases can also chroot() apache processes. The result is a sane and secure web server environment for your users, without kludges like PHP’s safe_mode.

    ```yaml
    apache_modules:
      peruser:
        maxclients          : 150
        minspareprocessors  : 2
        minprocessors       : 2
        maxprocessors       : 10
        expiretimeout       : 120
        keepalive           : 'Off'
        maxrequestsperchild : 1000
        multiplexers:
          - user: 'www-data'
            group: 'www-data'
          - user: 'hell'
            group: 'hell'
        processors:
          - user: 'sabrewulf'
            group: 'sabrewulf'
          - user: 'spynal'
            group: 'spynal'
    ```

> :information_source: MPM is mutual exclusive. You can't include both [MPM peruser](http://mpm-itk.sesse.net/), [MPM ITK](http://mpm-itk.sesse.net/), [MPM prefork](https://httpd.apache.org/docs/current/mod/prefork.html) or [MPM worker](https://httpd.apache.org/docs/current/mod/worker.html) on the same server.

## Reference

### **Apache main configuration**

The main configuration allow you to set overall configuration for the HTTP Server. And how it abstracts other configuration from others sections.

**```server_tokens```**

Determine the `Server` response header sent back to clients, including a description of the server's OS-type as well as information about compiled-in modules. **Default:** `Prod`.

**```server_signature```**

The ServerSignature directive allows the configuration of a trailing footer line under server-generated documents (error messages, mod_proxy ftp directory listings, mod_info output, ...). **Valid options:** ```'Off'```, ```'On'```. **Default:** ```'Off'```.

**```trace_enable```**

Controls how Apache handles TRACE requests (per RFC 2616) via the ```TraceEnable``` directive. **Valid options:** ```'Off'```, ```'On'```. **Default:** ```'Off'```.

**```servername```**

Sets the main server name. **Default:** the ```'fqdn'``` from ```ansible_fqdn```. You can see it by running ```ansible -m setup -a "filter=ansible_fqdn" hostname```.

**```server_root```**

Sets root for the serveurs configuration files. **Default:** By OS.

    Debian : '/etc/apache2'
    RedHat : '/etc/httpd'
    FreeBSD: '/usr/local'


**```pidfile```**

Sets the file to which the server records the process id of the daemon. **Default:** By OS.

    Debian : '\${APACHE_PID_FILE}'
    RedHat : 'run/httpd.pid'
    FreeBSD: '/var/run/httpd.pid'

**```timeout```**

Defines the time period in seconds Apache will wait for I/O in various circumstances: **Default:** ```120```.

**```keepalive```**

Determines whether to enable persistent TCP connections with the KeepAlive directive. **Valid options:** ```'Off'```, ```'On'```. **Default:** ```'On'```.

> :information_source: When apache is under proxy like ```haproxy``` or ```varnish```, it's a good idea to disable the **Keepalive** feature.

**```max_keepalive_requests```**

Limits the number of requests allowed per connection when **KeepAlive** is enabled. **Default:** ```100```.

**```keepalive_timeout```**

Sets the [`KeepAliveTimeout`][] which determine the time period in seconds Apache will wait for a subsequent request before closing the connection. **Default:** ```15```.

**```limit_request_field_size```**

Sets the [LimitRequestFields][] which detemine the limits of the number of HTTP request header fields that will be accepted from the client. **Default:** ```8190```.

**```user```**

Set the user Apache uses on any process to answer requests. **Default:** By OS.

    Debian : 'www-data'
    RedHat : 'apache'
    FreeBSD: 'www'

>  :information_source: Apache's parent process will continue to be run as root, but child processes will access resources as the user defined by this parameter.

**```group```**

Set the group Apache uses on any process to answer requests. **Default:** By OS.

    Debian : 'www-data'
    RedHat : 'apache'
    FreeBSD: 'www'

>  :information_source: Apache's parent process will continue to be run as root:root, but child processes will access resources as the group defined by this parameter.

**```rewrite_lock```**

Sets the filename for the synchronization lockfile which mod_rewrite needs to communicate with RewriteMap.

>  :information_source: Only in apache version 2.2 or lower.

>  :warning: Set this lockfile to a local path (not on a NFS-mounted device) when you want to use a rewriting map-program.

**```root_directory_options```**

Array of the desired options for the **/** directory. **Default:** ```'FollowSymLinks'```.

**```default_charset```**

Sets the [`AddDefaultCharset`][] for main configuration. **Default:** ```undefined```

**```log_level```**

Sets the [`LogLevel`][] which adjusts the verbosity of recorded messages in the error logs. **Default:** ```'Warn'```.

**```sendfile```**

Sets the [`EnableSendfile`][] which ensure Apache uses the kernel's **sendfile** feature to serve static files. **Valid options:** ```'Off'```, ```'On'```. **Default:** ```'On'```.

**```mod_dir```**

Sets where to place your Apache modules configuration files. **Default:** By OS.

    Debian : '/etc/apache2/ports.conf'
    RedHat : '/etc/httpd/conf.d'
    FreeBSD: '/usr/local/etc/apache22/Modules'

**```ports_file```**

Sets the path to the Apache ports configuration file. **Default:** `{{ apache_conf_dir }}/ports.conf`.


**```confd_dir```**

Sets the server's custom configuration directory location. **Default:** By OS.

    Debian : '/etc/apache2/conf.d'
    RedHat : '/etc/httpd/conf.d'
    FreeBSD: '/usr/local/etc/apache22'

**```vhost_dir```**

Sets virtual host configuration files' location.  **Default:** By OS.

    Debian : '/etc/apache2/sites-available'
    RedHat : '/etc/httpd/conf.d'
    FreeBSD: '/usr/local/etc/apache22/Vhosts'

**```include```**

Sets a custom include directories. **Valid options:** A list, such as:

```yaml
apache_include:
  - path: '/etc/apache2/custom_config'
  - path: '/etc/apache2/awh'
  - path: '/var/www/client1_vhosts'
    user : client1
    group: client1
  - path: '/var/www/client2_vhosts'
    user : client2
    group: client2
```
> :warning: Ensure users and groups associated with directories exists before running the playbook to avoid unexpected failures when creating them. Please see the [awh-users role](https://git.alterway.fr/ansibleroles/awh-users)
> :information_source: If path match /etc/apache2/ the `owner` and `group` will be always `root` for security reasons. If `user` and `group` not provided it take the `apache_user` and `apache_group` default value. Also note, all embeded apache path setted here will be dropped from dict before any execution.

**```default_log_formats```**

Hash of additional [`LogFormat`][] directives. **Valid options:** A hash, such as: I hope you don't need to surchage it.

```yaml
apache_default_log_formats:
   combined  : '"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined'
   common    : '"%h %l %u %t \"%r\" %>s %b" common'
   referer   : '"%{Referer}i -> %U" referer'
   agent     : '"%{User-agent}i" agent'
   forwarded : '"%{X-Forwarded-For}i %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"" forwarded'
   syslog    : '"%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\" %b %D %T %P %V:%p" syslog'

```

**```error_documents```**

Enable/Disable custom error documents on the Apache server. **Valid options:** Boolean,  **Default:** ```false```.

## Listeners configuration

Manage listen directives that define the Apache server's or a virtual host's listening address and port.

**```bind```**

Set [`Listen`][] which apache bind to. **Valid options:** List of `IP:PORT`. such as

```yaml
apache_bind:
  - '*:80'
  - '10.0.10.11:82'
  - '*:8080'
  - '*:443'
  - '*:8443 https'
```

**OR** (I prefere this format)

```yaml
apache_bind: ['*:80', '*:443', '10.0.10.11:82', '*:8080', '*:8443 https']
```

> :warning: Ensure that there is no service binding to any **```IP:PORT```** your have defined, otherwise apache won't start.


### `apache_modules`

Install, Enable, Disable and Configure Apache modules.

Here is how to install [`mod_pagespeed`][] module with default values and disable [`mod_deflate`][].

```yaml
apache_modules:
  pagespeed:
  deflate  :
    module_state: disabled
```

> :information_source:
> * Modules noted with a **`*`** indicate that the module has settings and a template that includes parameters to configure the module. Most Apache module parameters have default values and don't require configuration.
> * Modules noted with a **`@`** indicate that the module is installed and activated by default.
> * Modules noted with a **`&`** indicate that the module have a required parameters

* `actions`**@**
* `alias`**@**
* `auth_basic`**@**
* `auth_cas` **\* &**
* `auth_kerb`
* `authn_core`**@**
* `authn_file`**@**
* `authnz_ldap`**\***
* `authz_default`
* `authz_user`**@**
* `autoindex`**@**
* `cache`
* `cgi`
* `cgid`
* `dav`
* `dav_fs`
* `dav_svn`**\***
* `deflate`
* `dev`
* `dir`**\* @**
* `disk_cache`
* `event`
* `expires`
* `ext_filter`
* `fastcgi`
* `fcgid`
* `filter`
* `geoip`
* `headers`
* `include`
* `info`**\***
* `itk`
* `ldap`
* `mime`
* `mime_magic`**\***
* `negotiation`
* `nss`**\***
* `pagespeed`
* `passenger`**\***
* `perl`
* `peruser`
* `php`
* `prefork`**\***
* `proxy`**@**
* `proxy_fcgi`**@**
* `proxy_ajp`
* `proxy_balancer`
* `proxy_html`
* `proxy_http`
* `python`
* `reqtimeout`
* `remoteip`**\***
* `rewrite`
* `rpaf`**\***
* `setenvif`
* `security`
* `shib`**\***
* `speling`
* `ssl`**\***
* `status`**\***
* `suphp`
* `userdir`**\***
* `version`
* `vhost_alias`
* `worker`**\***
* `wsgi`
* `xsendfile`


#### `auth_cas`

Installs and manages [`mod_auth_cas`][].

 ```yaml
apache_modules:
  auth_cas:
    login_url    :  'https://helldorado.info/cas/login'
    validate_url :  'https://helldorado.info/cas/Validate'
```

**Parameters within `auth_cas`**:

- `authoritative`: Determines whether an optional authorization directive is authoritative and binding. **Default**: `undefined`.
- `certificate_path`: Sets the path to the X509 certificate of the Certificate Authority for the server in `cas_login_url` and `validate_url`. **Default:** `undefined`.
- `cache_clean_interval`: Sets the minimum number of seconds that must pass between cache cleans. **Default:** `undefined`.
- `cookie_romain`: Sets the value of the `Domain=` parameter in the `Set-Cookie` HTTP header. **Default:** `undefined`.
- `cookie_entropy`: Sets the number of bytes to use when creating session identifiers. **Default:** undef.
- `cookie_http_only`: Sets the optional `HttpOnly` flag when `mod_auth_cas` issues cookies. **Default:** `undefined`.
- `debug`: Determines whether to enable the module's debugging mode. **Default:** `'Off'`.
- `idle_timeout`: Amount of time an unused session is kept in cache. **Default:** `undefined`.
- `login_url`: ==**Required**==. Sets the URL to which the module redirects users when they attempt to access a CAS-protected resource and don't have an active session.
- `root_proxied_as`: Sets the URL the end users see when this Apache server is proxied. **Default:** `undefined`.
- `timeout`: Limits the number of seconds a `mod_auth_cas` session can remain active. **Default:** `undefined`.
- `validate_depth`: Limits the depth for chained certificate validation. **Default:** `undefined`.
- `validate_url`: ==**Required**==. Sets the URL to use when validating a client-presented ticket in an HTTP query string.
- `version`: The CAS protocol version to adhere to. **Valid options**: `'1'`, `'2'`. **Default: **`'2'`.


#### `authnz_ldap`

Installs and configures [`mod_authnz_ldap`][]

```yaml
apache_modules:
  authnz_ldap:
    verify_server_cert   : true
```

**Parameters within `authnz_ldap`:**

- `verify_server_cert`: Sets whether Apache should verify the ldap's server cert. **Valid options:** **`Boolean`**. **Default:** `false`


#### `cache_disk`

Installs and configures [`mod_cache_disk`][] ==only on Apache 2.4==. The default cache root depends on the Apache version and operating system:

```yaml
apache_modules:
  disk_cache:
    root: '/var/cache/mod_cache'
```

**Parameters within `cache_disk`**:

- `root`: Sets where apache should put its cache files. **Default:** By OS.

    **Debian**: `/var/cache/apache2/mod_cache_disk`
    **RedHat**: `/var/cache/httpd/proxy`
    **FreeBSD**: `/var/cache/mod_cache_disk`

#### `deflate`

Installs and manages [`mod_deflate`][].

```yaml
apache_modules:
  deflate:
    types: ['text/html text/plain text/xml', 'text/css', 'application/x-javascript application/javascript application/ecmascript', 'application/rss+xml', 'application/json', 'application/resource-lists+xml', 'application/rtf', 'application/soap+xml']
```

**Parameters within `deflate`**:
- `types`: An [array][] of [MIME types][MIME `content-type`] to be deflated. **Default:** `[ 'text/html text/plain text/xml', 'text/css', 'application/x-javascript application/javascript application/ecmascript', 'application/rss+xml', 'application/json' ]`.
- `notes`: A [Hash][] where the key represents the type and the value represents the note name. **Default:** `{ Input: 'instream', Output: 'outstream', Ratio: 'ratio' }`


#### `disk_cache`

Installs and configures [`mod_disk_cache`][] ==only on Apache 2.2==.

```yaml
apache_modules:
  disk_cache:
    root: '/var/cache/apache2/cache/mod_cache'
```

**Parameters within `disk_cache`**:

- `root`: Sets where apache should put its cache files. **Default:** By OS.

    **Debian**: `/var/cache/apache2/mod_cache_disk`
    **RedHat**: `/var/cache/mod_proxy`
    **FreeBSD**: `/var/cache/mod_cache_disk`


#### `event`

Installs and configures [`mod_mpm_event`][].

```yaml
apache_modules:
  event:
    startservers        : 20
    maxrequestworkers   : 150
```

**Parameters within `event`**:

- `listenbacklog`: Sets the maximum length of the pending connections queue via the module's [`ListenBackLog`][] directive. **Default:** `511`.
- `maxrequestworkers`: Sets the maximum number of connections Apache can process simultaneously via the module's [`MaxRequestWorkers`][] directive. **Default:** `150`.
- `maxclients`: ==(Apache 2.3.12 or older)==: Sets the maximum number of connections Apache can process simultaneously via the module's [`MaxRequestWorkers`][] directive. **Default:** `150`.
- `maxconnectionsperchild`: Limits the number of connections a child server handles during its life via the module's [`MaxConnectionsPerChild`][] directive. **Default**: `0`.
- `maxrequestsperchild`: ==(Apache 2.3.8 or older)== Limits the number of connections a child server handles during its life via the module's [`MaxConnectionsPerChild`][] directive. **Default**: `0`.
- `minsparethreads`: Sets the minimum number of idle threads via the [`MinSpareThreads`][] directives. Default: `25`.
- `maxsparethreads`: Sets the maximum number of idle threads via the [`MaxSpareThreads`][] directives. **Default:** `75`.
- `serverlimit`: Limits the configurable number of processes via the [`ServerLimit`][] directive. **Default:** `25`.
- `startservers`: Sets the number of child server processes created at startup via the module's [`StartServers`][] directive. **Default:** `2`.
- `threadlimit`: Limits the number of event threads via the module's [`ThreadLimit`][] directive. **Default:** `64`.
- `threadsperchild`: Sets the number of threads created by each child process via the [`ThreadsPerChild`][] directive. **Default:** `25`.


#### `expires`

Installs and configure [`mod_expires`][].

```yaml
apache_modules:
  expires:
    state  : 'On'
    by_type: ['text/html "access plus 1 month 15 days 2 hours"','image/gif "modification plus 5 hours 3 minutes"','image/gif A2592000','text/html M604800']
```

**Parameters within `expires`**:

- `state`: Enables generation of `Expires` headers for a document realm. **Valid options:** **`Boolean`**. **Default:** `true`.
- `default`: Default algorithm for calculating expiration time using [`ExpiresByType`][] syntax or [interval syntax][]. **Default:** `undefined`.
- `by_type`: Describes a set of [MIME `content-type`][] and their expiration times. **Valid options:** An [list][] of a valid MIME `content-type` (i.e. 'text/json') and its value following valid [interval syntax][]. **Default:** `undefined`.


#### `ext_filter`

Installs and configures [`mod_ext_filter`][].

```yaml
apache_modules:
  ext_filter:
    slowdown: 'mode=output cmd=/bin/cat preservescontentlength'
```

**Parameters within `ext_filter`**:

A hash of filter names and their parameters. **Default:** `undefined`.


#### `fastcgi`

Installs and configures [`mod_fastcgi`][].

```yaml
apache_modules:
  fastcgi:
    lib_path: '/var/lib/apache2/fastcgi'
```

**Parameters within `fastcgi`**:

- `lib_path`: Specifies a path to the module's libraries.


You can set the [`FastCGIExternalServer`][] via [`fastcgi`][] per vhosts or in global in `conf.d`

```yaml
apache_vhosts:
  'helldorado.info':
    fastcgi:
      server     : /fcgi-pool-helldorado
      host       : '12.0.0.1:9000'
      timeout    : 60
      pass_header: 'Authorization'
      fpm        :
        name   : hell
        ping   : fpm-ping
        status : fpm-ping
```

```yaml
apache_fastcgi:
  'helldorado':
    socket      : '/var/run/php5-fpm.sock'
    timeout     : '30'
    flush       : false
    alias       : '/var/www/php.fcgi'
    fpm:
      name   : hell
      ping   : fpm-ping
      status : fpm-ping
```

Then in you vhost set [AddType][] to your application type. **Default:** `'application/x-httpd-php .php'`. See [`fastcgi`][] and [`addtype`][] for more info.

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path: '/var/www/helldorado/apps'
        addtype: ['application/x-httpd-php .php']
```

> :information_source: [FastCGI][] for handling php is managed directly with [`apache_fastcgi`](#apache_fastcgi) or in [`apache_vhosts`](#apache_vhosts) via the [`fastcgi`](#fastcgi) parameter.

#### `fcgid`

Installs and configures [`mod_fcgid`][].

```yaml
apache_modules:
  fcgid:
    FcgidIPCDir         : '/var/run/fcgidsock'
    FcgidPassHeader     : 'Authorization'
    SharememPath        : '/var/run/fcgid_shm'
    AddHandler          : 'fcgid-script .fcgi'
    FcgidIdleTimeout    : 300
    FcgidProcessLifeTime: 3600
```

**Parameters within `fcgid`**:

A key value pair of parameters. For a full list of options, see the [official `mod_fcgid` documentation][`mod_fcgid`].

You can set the [`FcgidWrapper`](https://httpd.apache.org/mod_fcgid/mod/mod_fcgid.html#fcgidwrapper) via `fcgiwrapper` per directory, per vhosts.

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path       : '/var/www/helldorado'
        fcgiwrapper:
          command  : '/usr/local/bin/fcgiwrapper'
```

#### `geoip`

Installs and manages [`mod_geoip`][].

```yaml
apache_modules:
  geoip:
    enabled                : 'On'
    db_file                : ['/usr/local/share/GeoIP/GeoIP.dat', '/usr/local/share/GeoIP/GeoIPOrg.dat']
    db_flag                : MemoryCache
    enable_utf8            : 'On'
    scan_proxy_header_field: "HTTP_CLIENT_IP,HTTP_X_FORWARDED_FOR,X-Forwarded-For,HTTP_REMOTE_ADDR'
```

**Parameters within `geoip`**:

- `db_file`: Sets the path to your **GeoIP** database file. **Valid options:** a path, or an [array][] paths for multiple **GeoIP** database files. **Default:** `/usr/share/GeoIP/GeoIP.dat`.
- `enable`: Determines whether to globally enable [`mod_geoip`][]. **Valid options:** Boolean. Default: `On`.
- `db_flag`: Sets the GeoIP flag. Valid options: `CheckCache`, `IndexCache`, `MemoryCache`, `Standard`. **Default:** `Standard`.
- `output`: Defines which output variables to use. **Valid options:** `All`, `Env`, `Request`, `Notes`. **Default:** `All`.
- `enable_utf8`: Changes the output from **ISO-8859-1 (Latin-1)** to **UTF-8**. **Valid options:** Boolean.
- `scan_proxy_headers`: Enables the [GeoIPScanProxyHeaders][] option. **Valid options:** Boolean.
- `scan_proxy_header_field`: Specifies which header [`mod_geoip`][] should look at to determine the client's IP address.
- `use_last_xforwarededfor_ip`: Determines whether to use the first or last IP address for the client's IP if a comma-separated list of IP addresses is found. **Valid options:** Boolean.

> :information_source: Apache 2.4 users using mod_remoteip to pick the IP address of the user should disable [GeoIPScanProxyHeaders][]. [`mod_geoip`][] will use whatever [`mod_remoteip`][] provides.

#### `info`

Installs and configures [`mod_info`][], which provides a comprehensive overview of the server configuration.

```yaml
apache_modules:
  info:
    path                : '/server-info'
    allow_from          : ['10.0.1.0/24', '10.0.10.0/24']
    raw                 : 'deny from 10.0.1.16/32 10.0.10.16/32'
```

**Parameters within `info`**:

- `path`: Sets the path to your server info. **Valid options:** a URL path.  **Default:** `/server-info`.
- `allow_from`: Whitelist of IPv4 or IPv6 addresses or ranges that can access `/server-info`. **Valid options:** One or more IPv4 or IPv6 addresses in the CIDR form. **Default:** `['127.0.0.1','::1']`.
- `raw`: Sets a scalar parameters which put in the module in raw mode.

#### `itk`

Installs and manages [`mod_itk`][].

```yaml
apache_modules:
  itk:
    startservers        : 20
    maxclients          : 150
    minspareservers     : 25
    maxspareservers     : 75
    serverlimit         : 25
    listenbacklog       : 511
```

**Parameters within `itk`**:

Please see [`prefork`][]

Now you can manage it per vhosts via [`itk`][] parameters. For more info, see [`itk`][] on [`apache_vhosts`](apache_vhosts) section.

```yaml
apache_vhosts:
  'helldorado.info':
    itk:
      user          : helldorado
      group         : hell
      maxclientvhost: 90
```

#### `ldap`

Installs and configures [`mod_ldap`][]

```yaml
apache_modules:
    ldap:
      trusted_global_cert_type: 'CA_BASE64'
      trusted_global_cert_file: '/etc/ssl/certs/cert_ldap.pem'
      shared_cache_size       : 500000
      cache_entries           : 1024
      cache_ttl               : 600
      opcache_entries         : 1024
      opcache_ttl             : 600
```

**Parameters within `ldap`**:

- `cache_entries`: Sets the number of entries used to cache LDAP items.
- `cache_ttl`: Sets the time period that cached items remain valid.
- `opcache_entries`: Sets the number of entries used to cache LDAP compare operations.
- `opcache_ttl`: Sets the time that entries in the operation cache remain valid.
- `shared_cache_size`: Sets the size in bytes of the shared-memory cache.
- `trusted_global_cert_file`: Path and file name of the trusted CA certificates to use when establishing SSL or TLS connections to an LDAP server.
- `trusted_global_cert_type`: The global trust certificate format. **Default:** `CA_BASE64`.


#### `mime`

Configures [`mod_mime`][]

```yaml
apache_modules:
  mime:
    types_config: '/etc/mime.types'
```

**Parameters within `mime`**:

- `types_config`: Sets the location of the mime.types file. **Default:** By OS.

    ```bash
    Debian : 'etc/mime.types'
    RedHat : '/etc/httpd/mime.types'
    FreeBSD: '/usr/local/etc/apache22/mime.types'
    ```

#### `mime_magic`

Configures [`mod_mime_magic`][]

```yaml
apache_modules:
  mime_magic:
    file: '/etc/apache2/magic.conf'
```

**Parameters within `mime_magic`**:

- `file`: Sets the location of the magic file. **Default:** By OS

    ```bash
    Debian : '/etc/apache2/magic'
    RedHat : '/etc/httpd/magic'
    FreeBSD: '/usr/local/etc/apache22/magic'
    ```

#### `negotiation`

Installs and configures [`mod_negotiation`][].

```yaml
apache_modules:
  negotiation:
    language_priority: ['en', 'fr', 'de']
    force_language_priority: ['Prefer']
```

**Parameters within `negotiation`:**

- `force_language_priority`: An [array][] of options to set the `ForceLanguagePriority` option. **Valid option:** [array][]. **Default:** `['Prefer', 'Fallback']`.
- `language_priority`: An [array][] of languages to set the `LanguagePriority` option of the module. **Default:** `[ 'en', 'ca', 'cs', 'da', 'de', 'el', 'eo', 'es', 'et', 'fr', 'he', 'hr', 'it', 'ja', 'ko', 'ltz', 'nl', 'nn', 'no', 'pl', 'pt', 'pt-BR', 'ru', 'sv', 'zh-CN', 'zh-TW' ]

#### `pagespeed`

Installs and manages [`mod_pagespeed`][], a Google module that rewrites web pages to reduce latency and bandwidth.

```yaml
apache_modules:
  pagespeed:
    enable_filters : ['combine_css','combine_javascript']
    cache_path     : '/var/cache/mod_pagespeed/'
    rewrite_level  : PassThrough
    forbid_filters : ['rewrite_css','rewrite_javascript']
    disable_filters:
      - rewrite_images
      - combine_css
```

**Parameters within `pagespeed`**:

- `additional_domains`: Authorizing domains.
- `allow_view_stats`: **Valid option:** [array][]. **Default:** `['127.0.0.1', '::1']`.
- `allow_pagespeed_console`: **Valid option:** [array][]. **Default:**  `['127.0.0.1', '::1']`.
- `allow_pagespeed_message`: **Valid option:** [array][]. **Default:**  `['127.0.0.1', '::1']`.
- `cache_path`: **Default:** `'/var/cache/mod_pagespeed/'`.
- `collect_statistics`: Default: `'on'`.
- `css_flatten_max_bytes`: Default: `2048`.
- `css_image_inline_max_bytes`: Default: `2048`.
- `css_inline_max_bytes`: Default: `2048`.
- `css_outline_min_bytes`: Default: `3000`.
- `disable_filters`: **Valid option:** [array][].
- `enable_filters`: **Valid option:** [array][].
- `file_cache_size_kb`: **Default:** `102400`.
- `file_cache_clean_interval_ms`: Default: `3600000`.
- `filter_xhtml`: **Default:** `false`.
- `forbid_filters`: **Valid option:** [array][].
- `image_inline_max_bytes`: Default: `2048`.
- `image_max_rewrites_at_once`: Default: `8`.
- `inherit_vhost_config`: **Default:** `'on'`.
- `inode_limit`: Default: `500000`.
- `js_inline_max_bytes`: Default: `2048`.
- `js_outline_min_bytes`: Default: `3000`.
- `log_dir`: **Default:** `'/var/log/pagespeed'`.
- `lru_cache_per_process`: Default: `1024`.
- `lru_cache_byte_limit`: Default: `16384`.
- `memcache_servers`: **Valid option:** [array][].
- `message_buffer_size`: **Default:** `100000`.
- `num_expensive_rewrite_threads`: Default: `4`.
- `num_rewrite_threads`: Default: `4`.
- `rewrite_level`: **Default:** `CoreFilters`.
- `rewrite_deadline_per_flush_ms`: **Default:** `10`.
- `statistics_logging`: Default: `'on'`.

#### `passenger`

Installs and manages [`mod_passenger`][].

**Parameters within `passenger`**:

- `high_performance` Sets the [`PassengerHighPerformance`](https://www.phusionpassenger.com/library/config/apache/reference/#passengerhighperformance). **Valid options:** `'on'`, `'off'`.
- `pool_idle_time` Sets the [`PassengerPoolIdleTime`](https://www.phusionpassenger.com/library/config/apache/reference/#passengerpoolidletime).
- `max_pool_size` Sets the [`PassengerMaxPoolSize`](https://www.phusionpassenger.com/library/config/apache/reference/#passengermaxpoolsize).
- `max_request_queue_size` Sets the [`PassengerMaxRequestQueueSize`](https://www.phusionpassenger.com/library/config/apache/reference/#passengermaxrequestqueuesize).
- `max_requests` Sets the [`PassengerMaxRequests`](https://www.phusionpassenger.com/library/config/apache/reference/#passengermaxrequests).

#### `peruser`

Installs and manages [`mod_peruser`](http://mpm-itk.sesse.net/).

```yaml
apache_modules:
  peruser:
    maxrequestworkers      : 150
    minspareprocessors     : 2
    minprocessors          : 2
    maxprocessors          : 10
    expiretimeout          : 120
    keepalive              : 'Off'
    maxconnectionsperchild : 1000
    multiplexers:
      - user: 'www-data'
        group: 'www-data'
      - user: 'hell'
        group: 'hell'
    processors:
      - user: 'sabrewulf'
        group: 'sabrewulf'
      - user: 'spynal'
        group: 'spynal'
```

**Parameters within `peruser`**:

- `minspareprocessors`: Sets the minimum of idle workers in a single server environment. **Default:** `2`.
- `maxspareprocessors`: Sets the maximum of idle workers in a single server environment. **Default:** `10`.
- `minprocessors`: Sets the minimum worker limits for a single server environment. **Default:** `2`.
- `maxprocessors`: Sets the maximum worker limits for a single server environment. **Default:** `10`.
- `idletimeout`: Sets the maximum time a child can be idle. **Default:** `120`. **`0 = disable`**
- `expiretimeout`: Sets the maximum time a child can handle a single request (you want to set this high, if you want to allow long downloads). **Default:** `120`. **`0 = disable`**
- `keepalive`:
- `multiplexer`:
- `processor`:
- `maxrequestworkers`: Sets the maximum number of connections Apache can simultaneously process, via the module's [`MaxRequestWorkers`][] directive. **Default:** `150`.
- `maxclients`: ==(Apache 2.3.12 or older)==: Sets the maximum number of connections Apache can simultaneously process, via the module's [`MaxRequestWorkers`][] directive. **Default:** `150`.
- `maxconnectionsperchild`: Limits the number of connections a child server handles during its life, via the module's [`MaxConnectionsPerChild`][] directive. **Default**: `0`.
- `maxrequestsperchild`: ==(Apache 2.3.8 or older)== Limits the number of connections a child server handles during its life, via the module's [`MaxConnectionsPerChild`][] directive. **Default**: `0`.
- `minsparethreads`: Sets the minimum number of idle threads, via the [`MinSpareThreads`][] directives. Default: `25`.
- `maxsparethreads`: Sets the maximum number of idle threads, via the [`MaxSpareThreads`][] directives. **Default:** `75`.
- `serverlimit`: Limits the configurable number of processes via the [`ServerLimit`][] directive. **Default:** `25`.
- `startservers`: Sets the number of child server processes created at startup, via the module's [`StartServers`][] directive. **Default:** `2`.
- `threadlimit`: Limits the number of event threads via the module's [`ThreadLimit`][] directive. **Default:** `64`.
- `threadsperchild`: Sets the number of threads created by each child process, via the [`ThreadsPerChild`][] directive. **Default:** `25`.


#### `prefork`

Installs and configures [`mod_prefork`](https://httpd.apache.org/docs/current/mod/prefork.html).

```yaml
apache_modules:
  prefork:
    startservers        : 20
    maxclients          : 150
    minspareservers     : 25
    maxspareservers     : 75
    serverlimit         : 25
    listenbacklog       : 511
```

**Parameters within `prefrok`**:

- `listenbacklog`: Sets the maximum length of the pending connections queue via the module's [`ListenBackLog`][] directive. **Default:** `511`
- `maxrequestworkers`: Sets the maximum number of connections Apache can simultaneously process, via the module's [`MaxRequestWorkers`][] directive. **Default:** `150`.
- `maxclients`: ==(Apache 2.3.12 or older)==: Sets the maximum number of connections Apache can simultaneously process, via the module's [`MaxRequestWorkers`][] directive. **Default:** `150`.
- `maxconnectionsperchild`: Limits the number of connections a child server handles during its life, via the module's [`MaxConnectionsPerChild`][] directive. **Default**: `0`.
- `maxrequestsperchild`: ==(Apache 2.3.8 or older)== Limits the number of connections a child server handles during its life, via the module's [`MaxConnectionsPerChild`][] directive. **Default**: `0`.
- `minspareservers`: Sets the minimum number of idle child server processes, via the [`MinSpareServers`](https://httpd.apache.org/docs/2.4/fr/mod/prefork.html#minspareservers) directives. Default: `25`.
- `maxspareservers`: Sets the maximum number of idle child server processes, via the [`MaxSpareServers`](https://httpd.apache.org/docs/2.4/fr/mod/prefork.html#maxspareservers) directives. **Default:** `75`.
- `serverlimit`: Limits the configurable number of processes via the [`ServerLimit`][] directive. **Default:** `25`.
- `startservers`: Sets the number of child server processes created at startup, via the module's [`StartServers`][] directive. **Default:** `2`.

#### `proxy`

Installs and configures [`mod_proxy`][].

```yaml
apache_modules:
  proxy:
    requests: 'On'
    allow_from: ['10.0.1.0/24', '10.0.2.1/32']
```

> :warning: Do not enable proxying with ProxyRequests until you have secured your server. Open proxy servers are dangerous both to your network and to the Internet at large.

**Parameters within `proxy`**:

- `requests`: Enables/Disables forward (standard) proxy requests via the module's [`ProxyRequests`](https://httpd.apache.org/docs/2.4/fr/mod/mod_proxy.html#proxyrequests) directive . **Default:** `'Off'`.
- `allow_from`: Control who can access the proxy via the **`<Proxy>`** control block. **Valid options:** an [array][] of IPv4 or IPv6 addresses in the CIDR form. **Default:** `['127.0.0.1']`.

### `remoteip`

Installs and configures [`mod_remoteip`][].

```yaml
apache_modules:
  remoteip:
    proxy_ips        : ['10.0.1.16', '10.0.1.17']
    trusted_proxy_ip : ['10.0.1.0/28' ]
    header           : 'X-Forwarded-For'
```

**Parameters within `remoteip`**:

- `header`: Sets the header field which should be parsed for useragent IP addresses value, via the modules's [`RemoteIPHeader`](https://httpd.apache.org/docs/current/fr/mod/mod_remoteip.html#remoteipheader) directive. **Default:** `'X-Forwarded-For'`
- `proxy_ips`: Sets client intranet IP addresses trusted to present the RemoteIPHeader value, via the module's [`RemoteIPInternalProxyList`]()https://httpd.apache.org/docs/current/fr/mod/mod_remoteip.html#remoteipinternalproxy directive. **Default:** `127.0.0.1`.
- `proxies_header`: Sets the header field which will record all intermediate IP addresses value, via the modules's [`RemoteIPProxiesHeader`](https://httpd.apache.org/docs/current/fr/mod/mod_remoteip.html#remoteipproxiesheader).
- `trusted_proxy_ips`: Sets client intranet IP addresses trusted to present the [`RemoteIPHeader`](https://httpd.apache.org/docs/current/fr/mod/mod_remoteip.html#remoteipheader) value, via tue module's [`RemoteIPTrustedProxy`][] directive.


### `rpaf`

Installs and configures [`mod_rpaf`](https://github.com/gnif/mod_rpaf).

```yaml
apache_modules:
  rpaf:
    proxy_ips        : ['10.0.1.16', '10.0.1.17']
    sethostname      : 'On'
    header           : 'X-Forwarded-For'
```

**Parameters within `rpaf`**:

- `header`: Sets the header field which should be parsed for useragent IP addresses value, via the modules's [`RPAFheader`](https://github.com/gnif/mod_rpaf) directive. **Default:** `'X-Forwarded-For'`
- `proxy_ips`: Sets client intranet IP addresses trusted to present the RemoteIPHeader value, via the module's [`RPAFproxy_ips`](https://github.com/gnif/mod_rpaf) directive. **Default:** `127.0.0.1`.
- `sethostname`: Sets whether the header field which will record all intermediate IP addresses value should be updated, via the modules's [`RPAFsethostname`](https://github.com/gnif/mod_rpaf).

### `ssl`

Installs and configures [`mod_ssl`][].

```yaml
apache_modules:
  ssl:
    compression      : 'On'
    mutex            : 'default'
    protocol         : [ 'all', '-SSLv2', '-SSLv3']
    openssl_conf_cmd : 'Options -SessionTicket'
    session_cache    : '${APACHE_RUN_DIR}/ssl_scache(512000)'
    options          : ['StdEnvVars','FakeBasicAuth','OptRenegotiate']
    cipher           : 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSADSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS'
```

**Parameters within `ssl`**:

- `cipher`: Sets the Cipher Suite available for negotiation in SSL handshake, via the module's [`SSLCipherSuite`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html) directive. **Default:** `HIGH:MEDIUM:!aNULL:!MD5:!RC4`.
- `compression`: Enable compression on the SSL level, via the module's [`SSLCompression`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslcompression) directive. **Valid options:** `'on'`, `'off'`. **Default:** `'off'`.
- `cryptodevice`: Enable use of a cryptographic hardware accelerator, via the module's [`SSLCryptoDevice`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslcryptodevice) directive. **Default:** `builtin`.
- `honorcipherorder`: Sets the option to prefer the server's cipher preference order, via the module's [`SSLHonorCipherOrder`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslhonorcipherorder) directive. **Valid options:** `'on'`, `'off'`. **Default:** `'on'`.
- `mutex`: Configures mutex mechanism and lock file directory for all or specified mutexes via the module's [`Mutex`](https://httpd.apache.org/docs/current/en/mod/core.html#mutex) directive. **Default:** `'default'`.
- `openssl_conf_cmd`: Sets the OpenSSL parameters through its SSL_CONF API, via the modules's [`SSLOpenSSLConfCmd`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslopensslconfcmd) directive.
- `options`: Sets various SSL engine run-time options, via the module's [SSLOptions](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#ssloptions) directive. **Valid options:** an [array][].
- `pass_phrase_dialog`: Sets the type of pass phrase dialog for encrypted private keys, via the module's [`SSLPassPhraseDialog`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslpassphrasedialog) directive. **Default:** `builtin`.
- `protocol`: Sets the SSL protocol version (SSLv3, TLSv1, TLSv1.1, TLSv1.2), via the module's [`SSLProtocol`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslprotocol) directive. **Valid options:** an [array][].  **Default:** `[ 'all', '-SSLv2', '-SSLv3' ].
- `random_seed_bytes`: Sets the Pseudo Random Number Generator (PRNG) seeding source, via the module's [`SSLRandomSeed`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslrandomseed) directive. **Default:** `512`.
- `session_cache`: Sets the type of the global/inter-process SSL Session Cache via the module's [`SSLSessionCache`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslsessioncache) directive. **Default:** `512`. `'${APACHE_RUN_DIR}/ssl_scache(512000)'`
- `session_cache_timeout`: Sets the mumber of seconds before an SSL session expires in the Session Cache via the module's [`SSLSessionCacheTimeout`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslsessioncachetimeout) directive. **Default:** `300`.

> :warning: Enabling compression causes security issues in most setups (the so called CRIME attack).

### `status`

Installs and configures [`mod_status`][].

```yaml
apache_modules:
  status:
    allow_from     : ['10.0.1.0/24', '10.0.2.1/32']
    extended_status: 'On'
    path           : '/server-status'
```

**Parameters within `status`**:

- `allow_from`: Whitelist of IPv4 or IPv6 addresses or ranges that can access `/server-status`. **Valid options:** an [array][] of IPv4 or IPv6 addresses in the CIDR form. **Default:** `['127.0.0.1','::1']`.
- `extended_status`: Determines whether to track extended status information for each request, via the module's [`ExtendedStatus`][] directive. **Valid options:** `'on'`, `'off'`. **Default:** `'On'`.
- `path`: Sets the server location of the status page. **Default:** `'/server-status'`.

### `userdir`

Installs and configures [`mod_userdir`](https://httpd.apache.org/docs/2.4/en/mod/mod_userdir.html).

```yaml
apache_modules:
  userdir:
    dir          : public_html
    disable_root : true
    home         : /home
    options      : ['-Indexes', 'SymLinksIfOwnerMatch']
```

**Parameters within `userdir`**:

- `dir`: Sets the location of the user-specific directories, via the module's [`UserDir`](https://httpd.apache.org/docs/2.4/fr/mod/mod_userdir.html#userdir) directive. **Default:** `public_html`.
- `disable_root`: This turns off root user translations.
- `home`: Sets the userdir root directory. **Default:** `/home`.
- `options`: **Default:** Values of `apache_root_directory_options`

#### `worker`

Installs and manages [`mod_worker`](https://httpd.apache.org/docs/2.4/en/mod/worker.html).

```yaml
apache_modules:
  worker:
    startservers           : 20
    maxrequestworker       : 150
    minsparethreads        : 25
    maxsparethreads        : 75
    threadsperchild        : 25
    maxconnectionsperchild : 0
    serverlimit            : 25
    threadlimit            : 64
    listenbacklog          : 511
```

**Parameters within `worker`**:

Please see [`event`][]

#### `wsgi`

Enables Python support via [`mod_wsgi`][].

**Parameters within `wsgi`**:

- `python_home`: Defines the [`WSGIPythonHome`][] directive, such as '/path/to/venv'. **Valid options:** `path`.
- `python_path`: Defines the [`WSGIPythonPath`][] directive, such as '/path/to/venv/site-packages'. **Valid options:** `path`.
- `socket_prefix`: Defines the [`WSGISocketPrefix`](http://modwsgi.readthedocs.io/en/develop/configuration-directives/WSGISocketPrefix.html) directive, such as "\${APACHE_RUN_DIR}WSGI".


### `apache_vhosts`

Configure and manage apache virtual hosts.

The `apache_vhosts` uses [`include`](http://jinja.pocoo.org/docs/dev/templates/#include) from [Jinja2](http://jinja.pocoo.org/docs/dev/) to build the configuration file. All configuration is a fragment that can be customized. For more info about how it abstracts, please see the entry point of vhosts and included fragments.

The default apache vhosts sets up a virtual host on port 80, listening on all interfaces and serving the docroot parameter's default directory of `/var/www/default-site/`.

> :information_source: `apache_vhosts` is a hash where the key represents the name and the value can be an hash, dict, array, list, and more complexe object that combine all types.

#### `access_log`

Determines whether to configure `*_access.log` directives. (`dest`,`pipe`, or `format`). Valid options: **hash**. **Default:** `undefined`.

```yaml
apache_vhosts:
  access_log:
    dest  : '/var/log/apache2/access_helldorado.log'
    format: '"%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined'
```

**Parameters within `access_log`**:

- `format`: Specifies the use of either a [LogFormat][] nickname or a custom-formatted string for the access log. Default: `"'%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\" %b %D %T %P %V:%p' custom_vhost_log"`.
- `dest`: Sets the destination for the access log. **Valid options:** `'a path'`, `'syslog'`. **Default:** `${apache_logroot}/${apche_vhosts['servername']|default(apache_vhosts['item.key']}_access.log'`.
- `pipe`: Specifies a pipe where Apache sends access log messages. Default: `undefined`.
- `owner` : Specifies the owner of the folder. **Default:**  `root`.
- `group` : Specifies the group owner of the folder. **Default:**  `root`.


#### `action`

Sets CGI script for a particular handler or content-type.

```yaml
apache_vhosts:
  actions: 'image/gif'
```

#### `aliases`

Sets a list of hash to the virtual host to create [`Alias`][], [`AliasMatch`][], [`ScriptAlias`][] or [`ScriptAliasMatch`][] configuration via the [`mod_alias`][] directives. Hash keys can be any of `path`, `alias`, `aliasmatch`, `scriptalias`, `scriptaliasmatch`.

```yaml
apache_vhosts:
  aliases:
    - path: '/files/jpg.images/$1.jpg'
      aliasmatch: '^/image/(.*)\.jpg$'
    - path: '/ftp/pub/image'
      alias: '/image'
    - path: '/usr/local/share/cgi-bin$1'
      scriptaliasmatch: '^/cgi-bin(.*)'
    - path: '/usr/lib/nagios/cgi-bin/'
      scriptalias: '/nagios/cgi-bin/'
    - path: '/usr/share/nagios/html'
      alias: '/nagios'
```

**Parameters within `aliases`**:

> :information_source: Each list of hash require the path parameter. Also note each needs a corresponding context, such as **`<Directory /path/to/directory>`** or **`<Location /some/location/here>`**

- `path`: ==**Required**==. Sets the local PATH. **Valid options:** `file-path` or `directory-path`.
- `alias`: Maps URLs to filesystem locations via the module [`Alias`][] directive.
- `aliasmatch`: Maps URLs to filesystem locations using regular expressions via the module [`AliasMatch`][] directive. This directive is equivalent to [`Alias`][], but makes use of regular expressions, instead of simple prefix matching.
- `scriptalias`: Maps a URL to a filesystem location and designates the target as a CGI script via the module [`ScriptAlias`][] directive.
- `scriptaliasmatch`: Maps a URL to a filesystem location using a regular expression and designates the target as a CGI script via the module [`ScriptAliasMatch`][] directive. This directive is equivalent to [`ScriptAlias`][], but makes use of regular expressions, instead of simple prefix matching.

> :information_source: URLs with a (%-decoded) path beginning with URL-path will be mapped to local files beginning with directory-path. The URL-path is case-sensitive, even on case-insensitive file systems.

#### `allow_encoded_slashes`

Sets the [`AllowEncodedSlashes`][] declaration for the virtual host, overriding the server default. This modifies the virtual host responses to URLs with `\` and `/` characters. **Valid options:** `'nodecode'`, `'off'`, `'on'`.

```yaml
apache_vhosts:
  allow_encoded_slashes: 'on'
```

#### `default_charset`

Sets the charset to translate into via the [`CharsetDefault`][] directive.

```yaml
apache_vhosts:
  charset: ''
```

#### `directories`

An array of hashes to create [Directory](https://httpd.apache.org/docs/current/mod/core.html#directory), [File](https://httpd.apache.org/docs/current/mod/core.html#files), and [Location](https://httpd.apache.org/docs/current/mod/core.html#location) directive blocks.
```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path: '/var/www/hell'
        provider           : 'files'
        deny               : ['from all']
        addhandlers        : [handler : 'cgi-script' ,  extensions : '.cgi']
        auth_type          : 'basic'
        auth_name          : 'Restricted content'
        auth_basic_provider: 'file'
        auth_user_file     : '/etc/apache2/.helldorado_htpasswd'
        auth_require       : 'valid-user '
        php_values:
           include_path    : '.:/usr/local/lib/php'
           error_log       : '/var/log/fpm-php.www.log'
        php_admin_flags:
            log_errors     : 'on'
        rewrites:
          - comment : 'Lynx or Mozilla v1/2'
            cond    : ['%{HTTP_USER_AGENT} ^Lynx/ [OR]', '%{HTTP_USER_AGENT} ^Mozilla/[12]']
            rule    : ['^index\.html$ welcome.html']
      - path: '\.(html|xhtml)$'
        provider   : 'files'
        extra_parameters: 'HostnameLookups On'
      - path            : '^/dev'
        provider        : 'directory'
        allowoverride   : ['FileInfo', 'Indexes']
        require         : ['all granted', 'not host google.com', 'not host bing.com', 'not host microsoft.com']
        extra_parameters: 'HostnameLookups On'
```

**Parameters within `directories`**:

- `path`: Sets the path for the directory, files, and location blocks. Its value must be a path for the 'directory', 'files', and 'location' providers, or a regex for the 'directorymatch', 'filesmatch', or 'locationmatch' providers. Each hash passed to `directories` **must** contain `path` as one of the keys.
- `provider`: Set the type of path. **Valid options:** `directory`, `files`, `proxy`, `location`, `directorymatch`, `filesmatch`, `proxymatch` , `locationmatch`. **Default:** `directory`.

> :information_source: All other parameters can be under directories is documented on the same name.

#### `directory`

Manage "trailing slash" redirects and serving directory index files.

```yaml
apache_vhosts:
  'helldorado.info':
    directory:
      index         : ['index.php', 'index.html', '/cgi-bin/index.pl']
      check_handler : 'On'
      index_redirect: 'Off'
      slash         : 'On'
```

**Parameters within `directory`**:

- `check_handler`: Toggle how [`mod_dir`][] module responds when another handler is configured via the [`DirectoryCheckHandler`](https://httpd.apache.org/docs/current/fr/mod/mod_dir.html#directorycheckhandler) directive.  **Valid options:** `'On'`, `'Off'`.
- `index`: Sets List of resources to look for when the client requests a directory via the [`DirectoryIndex`](https://httpd.apache.org/docs/current/fr/mod/mod_dir.html#directoryindex) directive.
- `index_redirect`: Configures an external redirect for directory indexes via the [`DirectoryIndexRedirect`](https://httpd.apache.org/docs/current/fr/mod/mod_dir.html#directoryindexredirect). **Valid options:** `'On'`, `'Off'`.
- `slash`: Toggle how [`mod_dir`](https://httpd.apache.org/docs/current/fr/mod/mod_dir.html) module manage trailing slash redirects via the [`DirectorySlash`](https://httpd.apache.org/docs/current/fr/mod/mod_dir.html#directoryslash) directive. **Valid options:** `'On'`, `'Off'`.

#### `documentroot`

Sets the  [`DocumentRoot`][] location.

```yaml
apache_vhosts:
  'helldorado.info':
    documentroot  :
      path  : '/var/www/helldorado'
      user  : www-data
      group : www-data
      data:
        provider : git
        repo     : https://github.com/WordPress/WordPress.git
        version  : master
        bare     : yes
        update   : no
```

**Parameters within `documentroot`**:

- `path`: Sets the [`DocumentRoot`][] path.
- `create`: Create or not the directory. **Valid options:** `boolean` **Default:** `yes`
- `user`: Sets the owner of [`documentroot`] path.  **Default:** based on your OS.
- `group`: Sets the group of [`documentroot`] path.  **Default:** based on your OS.
- `link`: Ensure the path is a link by providing the source of link path
- `data`: An hash,
   - `provider`: Determine which method use to copy data to [`documentroot`] path. **Valid options:** `'copy'`, `'content'`, `'git'` .
   - `content`: Sets an content directly on a file like `index.php` Require `dest` parameter.
   - `dest`: Sets content destination when `provider` is `content`
   - `source`: Sets the data source (Shipped from master node) to target node when `provider` is `copy`.
   - `repo`: Sets git, SSH, or HTTP(S) protocol and address of the git repository.
   - `version`: Sets the version of the repository to check out. This can be the full `40-character SHA-1 hash`, the literal string `HEAD`, a `branch` name, or a `tag` name. **Default:** `'master'`
   - `update`: If `no`, do not retrieve new revisions from the origin repository. **Default:** `yes`.
   - `bare`: if `yes`, repository will be created as a bare repo, otherwise it will be a standard repo with a workspace. **Default:** `no`.
   - `force`: If `yes`, any modified files in the working repository will be discarded. **Default:** `yes`.
   - `refspec`: Add an additional [`refspec`](https://git-scm.com/book/be/v2/Git-Internals-The-Refspec) to be fetched. If version is set to a `SHA-1` not reachable from any **branch** or **tag**, this option may be necessary to specify the **ref** containing the `SHA-1`.


  > :information_source: For example on how to use all the parameter please see [Manage DocumentRoot][]

#### `env`

Manage environment variables for virtual hosts.

```yaml
apache_vhosts:
  'helldorado.info':
    env:
      setenv:
        - 'SPECIAL_PATH /foo/bin'
        - 'newrelic.app_name "SPYNAL"'
      setenvif:
        - 'Request_URI "\.gif$" object_is_image=gif'
        - 'object_is_image xbm XBIT_PROCESSING=1'
      passenv: ['LD_LIBRARY_PATH','LANGUAGE']
      unsetenv: ['LD_LIBRARY_PATH','SHLVL']
```

**Parameters within `env`**:

- `setenv`: Sets environment variables via the [`SetEnv`](https://httpd.apache.org/docs/2.4/fr/mod/mod_env.html#setenv) directive. **Valid options:** [Array].
- `setenvif`: Sets environment variables based on attributes of the request via the [`SetEnvIf`](https://httpd.apache.org/docs/2.4/fr/mod/mod_setenvif.html#setenvif) directive. **Valid options:** [Array].
- `passenv`: Passes environment variables from the shell via the [`PassEnv`](https://httpd.apache.org/docs/2.4/fr/mod/mod_env.html#passenv) directive. **Valid options:** [Array].
- `unsetenv`: Removes variables from the environment via the [`UnsetEnv`](https://httpd.apache.org/docs/2.4/fr/mod/mod_env.html#unsetenv) directive. **Valid options:** [Array].

#### `error_documents`

Manage what the server will return to the client in case of an error via the [`ErrorDocument`][] directive

```yaml
apache_vhosts:
  'helldorado.info':
    error_documents:
      - error_code: '503'
        document: '/var/www/helldorado/503.html'
      - error_code: '404'
        document: 'http://helldorado.info/missing/404.html'
      - error_code: '411'
        document: 'default'
```

**Parameters within `error_documents`**:

- `document`:  The path or URL to redirect when error occured.
- `error_code`: The error code. Please see [List of HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)

> :information_source: The special value `default` can be used to specify Apache httpd's simple hardcoded message. While not required under normal circumstances, default will restore Apache httpd's simple hardcoded message for configurations that would otherwise inherit an existing [`ErrorDocument`][].

#### `error_log`

Determines whether to configure `*_error.log` directives. (`dest`,`pipe`, or `format`). Valid options: **hash**.

```yaml
apache_vhosts:
  error_log:
    level : warn
    dest  : '/var/log/apache2/error_helldorado.log'
```

**Parameters within `error_log`**:
- `level`: Controls the verbosity of the [`ErrorLog`][]. **Valid options:** `'emerg'`, `'alert'`, `'crit'`, `'error'`, `'warn'`, `'notice'`, `'info'` or `'debug'`. **Default:** `'warn'`.
- `dest`: Sets the destination for the error log. **Valid options:** `'a path'`, `'syslog'`. **Default:** `${apache_logroot}/${apche_vhosts['servername']|default(apache_vhosts['item.key']}_error.log'`.
- `pipe`: Specifies a pipe where Apache sends errors log messages.
- `owner` : Specifies the owner of the folder. **Default:**  `root`.
- `group` : Specifies the group owner of the folder. **Default:**  `root`.


#### `fallbackresource`

Defines a default URL for requests that don't map to a file.

```yaml
apache_vhosts:
  'helldorado.info':
    fallbackresource: /index.html
```

#### `fastcgi`

Defines external FastCGI server to handle specific file types.

```yaml
apache_vhosts:
  'helldorado.info':
    fastcgi:
      server     : /fcgi-pool-helldorado
      host       : '127.0.0.1:9000'
      timeout    : 60
      pass_header: 'Authorization'
      fpm        :
        name   : hell
        ping   : fpm-ping
        status : fpm-status
```

**Parameters within `fastcgi`:**

- `host`: Determines the FastCGI's hostname or IP address and TCP port number.
- `socket`: Determines the path of FastCGI's unix socket to be used. such as: **`/var/run/php-fpm.sock`**.
- `timeout`: Sets the number of seconds a [FastCGI][] application can be inactive before aborting the request and logging the event at the error LogLevel. The inactivity timer applies only as long as a connection is pending with the FastCGI application. If a request is queued to an application, but the application doesn't respond by writing and flushing within this period, the request is aborted. If communication is complete with the application but incomplete with the client (the response is buffered), the timeout does not apply. **Default:** `30`
- `flush`: Forces [`mod_fastcgi`][FastCGI] to write to the client as data is received from the application. By default, `mod_fastcgi` buffers data in order to free the application as quickly as possible. **Valid options:** `'true'`, `'false'`.
- `pass_header`: Set the name of a Request Header to be passed in the request environment. This option makes available the contents of headers which are normally not available (e.g. Authorization) to a CGI environment. The passed header names are prefixed with "HTTP_" IAW the CGI specification. **Default:** `Authorization`.
- `virtual_path`: Sets [FastCGI][] handle URIs that resolve to this filename. The path set in this parameter does not have to exist in the local filesystem. **Default:** `/fastcgi-pool-${item.key}`.
- `alias`: Set the internally links actions with the FastCGI server. This alias must be unique. **Default:** `/usr/lib/cgi-bin/${item.key}`.
- `file_type`: Sets the [MIME `content-type`][] of the file to be processed by the FastCGI server. **Default:** `application/x-httpd-php-${item.key}`.
- `fpm`: Manage how to get information from [FastCGI Process Manager (FPM)](https://secure.php.net/manual/en/install.fpm.configuration.php)
    - `ping`: Set the ping URI to call the monitoring page of FPM. **Default:** `fpm-ping`.
    - `status`: Set the URI to view the FPM status page. **Default:** `fpm-status`.
    - `allow`:  Control who can access the status and ping page. **Default:** `127.0.0.1`.

> :warning: **`host`** and **`socket`** are mutually exclusive. You can't set both **`host`** and **`socket`** on the same [FastCGI][] Server.

> :information_source: It's possible to use global configuration of [FastCGI][] Server by using the [apache_fastcgi][] variable and allow all vitual hosts to use differents or single [FastCGI][] Server.

#### `filters`

Manage Context-sensitive smart filter configuration module via [`mod_filter`][]

```yaml
apache_vhosts:
  'helldorado.info':
    filters:
      - 'FilterDeclare   COMPRESS'
      - "FilterProvider COMPRESS DEFLATE \"%{Content_Type} = 'text/html'\""
      - 'FilterChain     COMPRESS'
      - 'FilterProtocol  COMPRESS DEFLATE change=yes;byteranges=no'
```

#### `headers`

Manage HTTP response headers via [`mod_headers`][]

```yaml
apache_vhosts:
  'helldorado.info':
    headers:
      - set my-custom-header "%D %t"
      - merge Cache-Control no-cache env=NO_CACHE
```

#### `includes`

Includes other configuration files from within the server configuration files.

```yaml
apache_vhosts:
  'helldorado.info':
    includes:
      - '/etc/apache2/map/hell.map'
      - '/etc/security/apache.conf'
      - '/etc/apache2/rewrite.conf'
      - '/etc/apache2/probe.conf'
```


#### `itk`

Configure [`itk`][]

```yaml
apache_vhosts:
  'helldorado.info':
    itk:
      user            : helldorado
      group           : hell
      maxclientvhost  : 55
      nice            : 2
```

In Apache 2.4 or newer only

```yaml
apache_vhosts:
  'helldorado.info':
    itk:
      AssignUserIDExpr : '%{reqenv:ITKUID}'
      AssignGroupIDExpr: '%{reqenv:ITKGID}'
      maxclientvhost   : 55
      limituidrange    : '1000 2000'
```

**Parameters within `itk`:**

- `user`: Specifies what uid the vhost will run as via the [`AssignUserId`](http://mpm-itk.sesse.net/) directive.
- `group`: Specifies what gid the vhost will run as via the [`AssignUserId`](http://mpm-itk.sesse.net/) directive.
- `useridexpr`:  ==(Apache 2.4 or newer only)== Like [`AssignUserID`](http://mpm-itk.sesse.net/), but takes in an Apache expression to dynamically choose user via the [`AssignUserIdExpr`][] directive.
- `groupidexpr`:  ==(Apache 2.4 or newer only)== Like [`AssignUserID`](http://mpm-itk.sesse.net/), but takes in an Apache expression to dynamically choose group via the [`AssignGroupIdExpr`][] directive.
- `nice`: Lets you nice some requests down, to give them less CPU time via the [`NiceValue`](http://mpm-itk.sesse.net/) directive
- `maxclientvhost`: Set a separate MaxClients for the vhost via the [`MaxClientsVHost`](http://mpm-itk.sesse.net/) directive . This can be useful if, say, half of your vhosts depend on some NFS server;
- `limituidrange`: ==(Apache 2.4 or newer only)==  Restrict setuid() calls to a given range.
- `limitgidrange`: ==(Apache 2.4 or newer only)==  Restrict setgid() calls to a given range


> :information_source: `LimitUIDRange` `LimitGIDRange` requires [seccomp v2](https://www.kernel.org/doc/Documentation/prctl/seccomp_filter.txt) (Linux 3.5.0 or newer).

#### `jk`

Sets up a virtual host with [`JkMount`](https://tomcat.apache.org/tomcat-3.3-doc/mod_jk-howto.html) and [`JkUnMount`](https://tomcat.apache.org/tomcat-3.3-doc/mod_jk-howto.html) directives to handle the paths for URL mapping between Tomcat and Apache using the [`mod_jk`](https://tomcat.apache.org/tomcat-3.3-doc/mod_jk-howto.html)

```yaml
apache_vhosts:
  'helldorado.info':
    jk:
      - worker: 'tomcatnode1'
        mount: '/*'
      - worker: 'tomcatnode1'
        unmount: '/*.jpg'
```

**Parameters within `jk`:**

- `mount|umount`: The URL prefix
- `worker`: The worker name

#### `passenger`

Manage Passenger configuration with [`mod_passenger`][]

```yaml
apache_vhosts:
  'helldorado.info':
    passenger:
      base_uris:
        - '/api'
        - '/console'
      app_root: '/usr/share/app1'
      app_env: production
      user: spynal
```

**Parameters within `passenger`:**

- `app_env`: Set environment variables for the current App via the module [`PassengerAppEnv`](https://www.phusionpassenger.com/library/config/apache/reference/#passengerappenv) directive. **Default:** `'production'`
- `app_root`: Set the location of the Passenger app directory. **Default:** Parent directory of the DocumentRoot via the module [`PassengerAppRoot`](https://www.phusionpassenger.com/library/config/apache/reference/#passengerapproot) directive.
- `base_uris`: Specify that the given URI is an distinct application that should be served by Passenger via the module [`PassengerBaseURI`](https://www.phusionpassenger.com/library/config/apache/reference/#passengerbaseuri) directive.
- `max_instances`: Set the maximum number of application processes that should exist for a given application via the module [`PassengerMaxInstances`](https://www.phusionpassenger.com/library/config/apache/reference/#passengermaxinstances) directive.
- `min_instances`: Set the minimum number of application processes that should exist for a given application via the module [`PassengerMinInstances`](https://www.phusionpassenger.com/library/config/apache/reference/#passengermininstances) directive.
- `pre_start`: Sets the number of child server processes created at startup via the module [`PassengerPreStart`][] directive.
- `start_timeout`: Set a timeout for the startup of application processes via the module [`PassengerStartTimeout`][] directive.
- `user`: Override the user to run the web application as, regardless of the ownership of the startup file via the module [`PassengerUser`][] directive.
- `group`: Override the group to run the web application as, regardless of the ownership of the startup file via the module [`PassengerGroup`][] directive.

#### `php_admin_flags`

Set a flags that cannot be overwritten by a user or an application.

```yaml
apache_vhosts:
  'helldorado.info':
    php_admin_flags:
      log_errors: 'on'
```

### `php_admin_values`

Set a values that cannot be overwritten by a user or an application.

```yaml
apache_vhosts:
  'helldorado.info':
    php_admin_values:
      error_log: '/var/log/fpm-php.www.log'
```

#### `php_flags`

Set a flags that can be overwritten by a user or an application.

```yaml
apache_vhosts:
  'helldorado.info':
    php_flags:
      log_errors: 'on'
```

#### `php_values`

Set a values that can be overwritten by a user or an application.

```yaml
apache_vhosts:
  'helldorado.info':
    php_values:
      error_log: '/var/log/fpm-php.www.log'
```

> :information_source: See [How to change PHP configuration settings ](https://secure.php.net/manual/en/configuration.changes.php)


#### `proxy_dest`

Specifies the destination address of a [ProxyPass](https://httpd.apache.org/docs/current/mod/mod_proxy.html#proxypass) configuration.

#### `proxy_dest_match`

This directive is equivalent to [`proxy_dest`][], but takes regular expressions, see [ProxyPassMatch](https://httpd.apache.org/docs/current/mod/mod_proxy.html#proxypassmatch) for details.

#### `proxy_dest_reverse_match`

Allows you to pass a ProxyPassReverse if [`proxy_dest_match`][] is specified. See [ProxyPassReverse](https://httpd.apache.org/docs/current/mod/mod_proxy.html#proxypassreverse) for details.


#### `proxy_fcgi`

Defines external FastCGI server to handle specific file types with [mod_proxy_fcgi].

 ```yaml
 apache_vhosts:
   'helldorado.info':
     proxy_fcgi:
       path       : '".+\.ph(ar|p|tml)$"'
       host       : '127.0.0.1:9000'
       enable_reuse: 'on'
       pass_header: '^Authorization$ "(.+)" HTTP_AUTHORIZATION=$1'
 ```

**Parameters within `proxy_fcgi`:**

- `path`: Sets the public PATH sent to reverse proxied server. **Valid options:** `string`, `PCRE`. **Default:** `'".+\.ph(ar|p|tml)$"'`
- `host`: Determines the FastCGI's hostname or IP address and TCP port number.
- `socket`: Determines the path of FastCGI's unix socket to be used. such as: **`/var/run/php-fpm.sock`**. **Default:** `/var/run/php-fpm.sock`
- `enable_reuse`: Sets convenience for scheme handlers that require opt-in for connection reuse. 2.4.11 and later only.. **Default:** `'on'` if `host` used instead `socket`.
- `pass_header`: Set the name of a Request Header to be passed in the request environment. This option makes available the contents of headers which are normally not available (e.g. Authorization) to a CGI environment. The passed header names are prefixed with "HTTP_" IAW the CGI specification. **Default:** `^Authorization$ "(.+)" HTTP_AUTHORIZATION=$1`.

> :warning: **`host`** and **`socket`** are mutually exclusive. You can't set both **`host`** and **`socket`** on the same [FastCGI][] Server.

#### `proxy_no_uris`

Specifies URLs you do not want to proxy. This parameter is meant to be used in combination with [`proxy_dest`](#proxy_dest).

#### `proxy_no_uris_match`

This directive is equivalent to [`proxy_no_uris`](#proxy_no_uris), but takes regular expressions.

#### `proxy_pass`

Specifies an list of array of `path and URI` values for a [ProxyPass](https://httpd.apache.org/docs/current/mod/mod_proxy.html#proxypass) configuration.

```yaml
apache_vhosts:
  'helldorado.info':
    proxy_pass:
      - path : '/a'
        url : 'http://backend-a/'
      - path : '/b'
        url : 'http://backend-b/'
      - path : '/c'
        url : 'http://backend-a/c'
        params : ['max':20, 'ttl':120, 'retry':300]
      - path : '/d'
        url : 'http://backend-a/d',
        options : ['Require':'valid-user', 'AuthType':'Kerberos', 'AuthName':'Kerberos Login']
      - path : '/xy'
        url : 'http://backend-xy'
        reverse_urls : ['http://backend-x', 'http://backend-y']
      - path : '/ad'
        url : 'http://backend-a/d'
        params : ['retry' : '0', 'timeout' : '5']
      - path : '/e'
        url : 'http://backend-a/e',
        keywords : ['nocanon', 'interpolate']
      - path : '/f'
        url : 'http://backend-f/'
        setenv : ['proxy-nokeepalive 1','force-proxy-request-1.0 1']
      - path : '/g'
        url : 'http://backend-g/'
        reverse_cookies : [{path : '/g', url : 'http://backend-g/',}, {domain : 'http://backend-g', url : 'http:://backend-g'}]
```

**Parameters within `proxy_pass`:**

- `path`: **==Required==**. Sets the public PATH sent to reverse proxied server. **Valid options:** `string`.
- `params`. Allows for ProxyPass key-value parameters, such as connection settings. For more info see [`ProxyPass`][] section **'ProxyPass key=value Parameters'** and the described tables below. **Valid options:** [Hash](https://docs.ansible.com/ansible/YAMLSyntax.html). ++**See above example**++
- `reverse_cookies`. Adjusts the **Domain** and **Path** string in Set-Cookie headers from a reverse proxied server via the module  [`ProxyPassReverseCookiePath`](https://httpd.apache.org/docs/current/en/mod/mod_proxy.html#proxypassreversecookiepath) and [`ProxyPassReverseCookieDomain`](https://httpd.apache.org/docs/current/en/mod/mod_proxy.html#proxypassreversecookiedomain) directives. **Valid options:** [Hash](https://docs.ansible.com/ansible/YAMLSyntax.html). ++**See above example**++
  - `path`: Sets the Path string in Set-Cookie headers
  - `url`:  **==Required==**. Sets the URL in HTTP response headers sent from a reverse proxied server.
  - `domain`: Sets the Domain string in Set-Cookie headers
- `reverse_urls`. Adjusts the URL in HTTP response headers sent from a reverse proxied server via the module [`ProxyPassReverse`](https://httpd.apache.org/docs/current/en/mod/mod_proxy.html#proxypassreverse) directive. **Valid options:** [Array][].  ++**See above example**++
- `setenv`. Sets [environment variables](https://httpd.apache.org/docs/current/mod/mod_proxy.html#envsettings) for the proxy directive. **Valid options:** [Array][]. ++**See above example**++
- `url`: Sets the URL in HTTP response headers sent from a reverse proxied server. **Valid options:** `string`.

#### `rack_base_uris`

Specifies the resource identifiers for a rack configuration. The file paths specified are listed as rack application roots for [Phusion Passenger](http://www.modrails.com/documentation/Users%20guide%20Apache.html#_railsbaseuri_and_rackbaseuri).

```yaml
apache_vhosts:
  'helldorado.info':
    rack_base_uris: ['/rackapp1', '/rackapp2']
```

> :warning: Deprecated in 3.0.0 in favor of [`PassengerBaseURI`][]. use [passenger](#passenger-2) `base_uri` parameter instead `rack_base_uris`

#### `redirect`

Sends an external redirect asking the client to fetch a different URL based on regular expression or not and set the status. Hash keys can be any of `source`, `source_match`, `destination`,

```yaml
apache_vhosts:
  'helldorado.info':
    redirect:
      - source: '/images/'
        destination: 'http://static.helldorado.info/'
        status: 'permanent'
      - source: '/downloads'
        destination: 'http://download.helldorado.info/'
      - source_match: '\.git(/.*|$)/'
        destination: 'http://gitlab.helldorado.info/'
      - source_match: '(.*)\.gif$'
        destination: 'http://helldorado.info/gif/$1.gif'
        status: 'temp'
```

**Parameters within `redirect`:**

- `destination`:  Sets the new URL-path. **Valid options:** `string`. The new URL may be either an absolute URL beginning with a scheme and hostname, or a URL-path beginning with a slash. In this latter case the scheme and hostname of the current server will be added.
- `source`: **==Required==**. Sets the old URL-path. **Valid options:** `string`. The old URL-path is a case-sensitive (%-decoded) path beginning with a slash. A relative path is not allowed.
- `source_match:` This directive is equivalent to `source`, but makes use of regular expressions, instead of simple prefix matching.
- `status`: Sets the return HTTP status codes. **Valid options:** `permanent` , `temp` , `seeother` , `gone`. Other status codes can be returned by giving the numeric status code as the value of status. If the status is between `300` and `399`, the URL argument must be present. If the status is not between 300 and 399, the URL argument must be omitted. The status must be a valid HTTP status code.

Status | Description
  ---|---
  permanent | Returns a permanent redirect status (301) indicating that the resource has moved permanently.
  temp| Returns a temporary redirect status (302). This is the default.
  seeother| Returns a "See Other" status (303) indicating that the resource has been replaced.
  gone| Returns a "Gone" status (410) indicating that the resource has been permanently removed. When this status is used the URL argument should be omitted.

> :warning: Redirect directives take precedence over [`Alias`][] and [`ScriptAlias`][] directives, irrespective of their ordering in the configuration file. Redirect directives inside a Location take precedence over Redirect and Alias directives with an URL-path.

> :information_source: If no status argument is given, the redirect will be "temporary" (HTTP status 302). This indicates to the client that the resource has moved temporarily. The status argument can be used to return other HTTP status codes:


#### `request_headers`

Configure HTTP [request headers](https://httpd.apache.org/docs/current/mod/mod_headers.html#requestheader) in various ways, including adding additional request headers, removing request headers... **Valid options:** [Array][].


```yaml
apache_vhosts:
  'helldorado.info':
    request_headers:
      - 'set SSL-CLIENT-VERIFY "%{SSL_CLIENT_VERIFY}s'
      - 'set Ssl-Client-Verify "%{SSL_CLIENT_VERIFY}s"'
      - 'unset Request-Range'
      - 'add X-LocalHeader "Headers For the Win"'
```

#### `require`

Sets a Require directive as per the Apache [mod_authz][].

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path   : '/var/www/helldorado/source_files'
        require: ['not ip 38.100.19.8/29', 'not ip 65.222.185.72', 'not group locked']
```

> :information_source: `require` When multiple **Require** directives are used in a single configuration section and are not contained in another authorization directive like <RequireAll>, they are implicitly contained within a <RequireAny> directive. Thus the first one to authorize a user authorizes the entire request, and subsequent Require directives are ignored.

```yaml
apache_vhosts:
  'helldorado.info':
    directories:
      - path   : '/var/www/helldorado/source_files'
        require:
          - enclose: all
            requires: ['method GET POST OPTIONS', 'ldap-group cn=Administrators,o=awh', 'ldap-attribute o="st"']
          - enclose: any
            requires: ['group admin', 'group wheel', 'group god']
```

**Parameters within `require`:**
- `enclose`: Set the scope of directive. **Valid options:** `all|any|none`. Other values are silently ignored.
- `requires`: List of requires directives.
- `unmanaged:` Ensure will not be set at all. This is useful for complex authentication/authorization requirements which are handled in a **`extra_parameters`**.

> :information_source: `require` can take directly a list of requires directives.

#### `rewrites`

Creates URL rewrite rules via [`mod_rewrite`][].  **Valid options:** [Array][] of hashes. Hash keys can be any of `comment`, `base`, `cond`, `rule` or `map`.

```yaml
apache_vhosts:
  'helldorado.info':
    rewrites:
      - comment : 'Lynx or Mozilla v1/2'
        cond    : ['%{HTTP_USER_AGENT} ^Lynx/ [OR]', '%{HTTP_USER_AGENT} ^Mozilla/[12]']
        rule    : ['^index\.html$ welcome.html']
      - comment : 'Internet Explorer'
        cond    : ['%{HTTP_USER_AGENT} ^MSIE'],
        rule    : ['^index\.html$ /index.IE.html [L]']
      - comment : 'Apps base'
         base    : /apps/
         rule    : ['^index\.cgi$ index.php', '^index\.html$ index.php', '^index\.asp$ index.html']
      - comment : 'Rewrite to lower case'
         cond    : ['%{REQUEST_URI} [A-Z]']
         map     : ['lc int:tolower']
         rule    : ['(.*) ${lc:$1} [R=301,L]']
```

You can set rewrite parameters at a global scope.

```yaml
apache_vhosts:
  'helldorado.info':
    rewrite_base: /combo
    rewrite_options: AllowNoSlash
```

**Parameters within `rewrites`:**

- `base`: Sets the base URL for per-directory rewrites. **Valid options:** `string` => `URL-path`
- `comment`: Set an comment for this rules.
- `cond`: Defines a condition under which rewriting will take place via the module's [`RewriteCond`][] directive. **Valid options:** [Array][]
- `map`: Defines a mapping function for key-lookup via the module's [`RewriteMap`][] directive. **Valid options:** [Array][]
- `rule`: Defines rules for the rewriting engine via the module's [`RewriteRule`][] directive. **Valid options:** [Array][]

#### `security`

Configures the [`mod_security`][] for the virtual host context.

```yaml
apache_vhosts:
  'helldorado.info':
    security:
      disable_ids  : { /location1: [ 90015, 90016 ] }
      disable_ids  : { [ 90025, 90030 ] }
      disable_vhost: no
      disable_ips  : ['192.168.0.52','2001:db8:85a3:8d3:1319:8a2e:370:0/24']
      body_limit   : 134217728
```

**Parameters within `security`:**

- `body_limit`: Configures the maximum request body size (in bytes) ModSecurity will accept for buffering via the module's [`SecRequestBodyLimit`](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual#SecRequestBodyLimit) directive.
- `disable_ids`: Array of [`mod_security`][] IDs to remove from the virtual host via the module's [SecRuleRemoveById](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual#SecRuleRemoveById) directive. Also takes a hash allowing removal of an ID from a specific location.
- `disable_ips`: Specifies an array of IP addresses to exclude from [`mod_security`][] rule matching via the module's [SecRule](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual#SecRule) directive.
- `disable_vhost`: Disables [`mod_security`][] on a virtual host. **Valid options:** Boolean. **Default:** `no`

#### `serveraliases`

Sets the [ServerAliases](https://httpd.apache.org/docs/current/mod/core.html#serveralias) of the site. **Valid options:** [Array]

```yaml
apache_vhosts:
  'helldorado.info':
    serveraliases: ['spynal.helldorado.info' , 'sabrewulf.helldorado.info fulgor.helldorado.info']
```

#### `servername`

Sets the [ServerName](https://httpd.apache.org/docs/current/mod/core.html#servername) of the site. **Valid options:** `[scheme://]domain-name|ip-address[:port]`. **Default:** [`item.key`][]

```yaml
apache_vhosts:
  'helldorado.info':
    serveraliases: www.helldorado.info
```

> :information_source: Failure to set [ServerName](https://httpd.apache.org/docs/current/mod/core.html#servername) to a name that your server can resolve to an IP address will result in a startup warning. httpd will then use whatever hostname it can determine, using the system's hostname command. This will almost never be the hostname you actually want.

#### `ssl`

Manage SSL via [`mod_ssl`][] for the virtual host. SSL virtual hosts only respond to HTTPS queries.

```yaml
apache_vhosts:
  'helldorado.info-ssl':
    bind        : ['*:443']
    ssl         :
      certs_dir    : '/etc/apache2/certs'
      autosigned   :
        subject    : '/C=FR/ST=PARIS/L=Paris/O=HELLDORADO/OU=DEVOPS/CN=helldorado.info'
        days       : 365
        extensions : v3_ca
        bit        : 4096
```

```yaml
apache_vhosts:
  'helldorado.info-ssl':
    bind        : ['*:443']
    ssl         :
      certs_dir: '/etc/apache2/certs'
      ssl_src  : 'data/apache/certs/'
      cert     : '/etc/apache2/certs/www.helldorado.info.cert'
      key      : '/etc/apache2/certs/www.helldorado.info.key'
      ca       : '/etc/apache2/certs/www.helldorado.info.ca'
      protocol : ['all', '-SSLv2', '-SSLv3']
      cipher   : 'HIGH:MEDIUM:!aNULL:!MD5:!RC4'
      options  : ['StdEnvVars', '-ExportCertData']
```

**Parameters within `ssl`:**

- `autosigned`: Create an autosigned certificates. **Valid options:** Hash.
   - `bit`: Sets the key size via the `-newkey rsa:bits` parameter. **Valid options:** `INTEGER`. **Default:** `2048`
   - `days`: Sets the number of days a certificate generated by -x509 is valid for via the `-days` parameter. **Valid options:** `INTEGER`. **Default:** `365`
   - `extensions`: Specify certificate extension section via the `-extensions` parameter. **Valid options:** `string`. **Default:** `v3_ca`.
   - `subject`: Set or modify request subject via the `-subj` parameter. **Valid options:** `string`. **Default:** `'/C=FR/ST=Ile-De-France/L=Paris/O=IT/CN=${ansible_fqdn}'`.
- `ca`: Sets the Directory of PEM-encoded CA Certificates for Client Auth
- `cert`: ==Required if **`autosigned`** is not defined==. Sets the Server PEM-encoded X.509 certificate data file via the module's [`SSLCertificateFile`][] directive. **Valid options:** `path`.
- `chain`: Sets the file of PEM-encoded Server CA Certificates via the module's [`SSLCertificateChainFile`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslcertificatechainfile) directive. **Valid options:** `path`.
- `certs_dir`: Sets the paths of certificates directory. **Valid options:** `path`. **Default:** [`apache_ssl_certs_dir`](#apache_ssl_certs_dir)
- `cipher`: Sets the Cipher Suite available for negotiation in SSL handshake via the module's [`SSLCipherSuite`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslciphersuite) directive. **Valid options:** `path`
- `crl`: Sets the file of concatenated PEM-encoded CA CRLs for Client Auth via the module's [`SSLCARevocationFile`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslcarevocationfile) directive. **Valid options:** `string` such as `RC4-SHA:AES128-SHA:HIGH:MEDIUM:!aNULL:!MD5`
- `crl_check`: Enable CRL-based revocation checking via the module's [`SSLCARevocationCheck`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslcarevocationcheck) directive. **Valid options:** `chain|leaf|none` and flags `no_crl_for_cert_ok`.
- `crl_path`: Sets the directory of PEM-encoded CA CRLs for Client Auth via the module's [`SSLCARevocationPath`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslcarevocationpath) directive. **Valid options:** `path`.
- `honorcipherorder`: Sets Option to prefer the server's cipher preference order via the module's [`SSLHonorCipherOrder`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslhonorcipherorder) directive. **Valid options:** `on` , `off`.
- `openssl_conf_cmd`: Configure OpenSSL parameters through its SSL_CONF API via the module's [`SSLOpenSSLConfCmd`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslopensslconfcmd) directive. **Valid options:** `string` such as: `Options -SessionTicket,ServerPreference` , `ECDHParameters brainpoolP256r1` , `SignatureAlgorithms RSA+SHA384:ECDSA+SHA256`.
- `options`: Configure various SSL engine run-time options via the module's [`SSLOptions`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#ssloptions) directive. **Valid options:** [Array] such as: `['StdEnvVars', '-ExportCertData']`.
- `protocol`: Configure usable SSL/TLS protocol versions via the module's [`SSLProtocol`](https://httpd.apache.org/docs/current/en/mod/mod_ssl.html#sslprotocol) directive. **Valid options:** [Array] such as: `['all', '-SSLv2', '-SSLv3']`.
- `verify_client`: Sets the Type of Client Certificate verification via the module's [`SSLVerifyClient`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslverifyclient) directive. **Valid options:** `none` , `optional`, `require`, `optional_no_ca`.
- `ssl_src`: Sets an local certifcate file to push on target node from the master node. **Valid options:** `path`.
- `verify_depth`: Sets the maximum depth of CA Certificates in Client Certificate verification via the module's [`SSLVerifyDepth`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslverifydepth) directive. **Valid options:** `INTEGER`

> :information_source: SSLCertificateChainFile is deprecated. Became obsolete with version **2.4.8**, when [`SSLCertificateFile`](https://httpd.apache.org/docs/2.4/fr/mod/mod_ssl.html#sslcacertificatefile) was extended to also load intermediate CA certificates from the server certificate file.

> :warning: For security reasons, please make sure the `ssl_src` dir is only readable by root. It can be a relative or absolute path. Also note: If you use `autosigned` certificates, please set an custom `subject`.

#### `ssl_proxy`

Manage SSL/TLS Protocol Engine for proxy.

```yaml
apache_vhosts:
  'helldorado.info-ssl':
    bind        : ['*:443']
    ssl_proxy         :
      check_peer_name : 'On'
      protocol        : ['all', '-SSLv2', '-SSLv3']
      verify          : none
```

**Parameters within `ssl_proxy`:**

- `check_peer_cn`: Configure whether to check the remote server certificate's CN field via the module's [`SSLProxyCheckPeerCN`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxycheckpeercn) directive. **Valid options:** `on` , `off`.
- `check_peer_name`: Configure host name checking for remote server certificates via the module's [`SSLProxyCheckPeerName`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxycheckpeername) directive. **Valid options:** `on` , `off`.
- `machine_cert`: Sets the file of concatenated PEM-encoded client certificates and keys to be used by the proxy via the module's [`SSLProxyMachineCertificateFile`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxymachinecertificatefile) directive. **Valid options:** `path`.
- `machine_chain`: Sets the file of concatenated PEM-encoded CA certificates to be used by the proxy for choosing a certificate via the module's [`SSLProxyMachineCertificateChainFile`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxymachinecertificatechainfile) directive. **Valid options:** `path`.
- `protocol`: Configure usable SSL protocol flavors for proxy usage via the module's [`SSLProxyProtocol`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxyprotocol) directive. **Valid options:** [Array] such as: `['all', '-SSLv2', '-SSLv3']`.
- `verify`: Sets the Type of Client Certificate verification via the module's [`SSLProxyVerify`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxyverify) directive. **Valid options:** `none` , `optional`, `require`, `optional_no_ca`.

> :warning: If [`SSLProxyMachineCertificateFile`](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxymachinecertificatefile) directive is enabled, all of the certificates in the file will be trusted as if they were also in [SSLProxyCACertificateFile](https://httpd.apache.org/docs/current/fr/mod/mod_ssl.html#sslproxycacertificatefile).

#### `suexec`

Allows users to run CGI and SSI applications as a different user  IDs.


```yaml
apache_vhosts:
  'helldorado.info':
    suexec         :
      user  : spynal
      group : spy
```

**Parameters within `suexec`:**

- `group`: Sets the group for CGI programs to run as via the module's directive [`SuexecUserGroup`](https://httpd.apache.org/docs/current/fr/suexec.html). **Valid options:** `string`. **Default:** `user`.
- `user`: ==Required== Sets the user for CGI programs to run as via the module's directive [`SuexecUserGroup`](https://httpd.apache.org/docs/current/fr/suexec.html). **Valid options:** `string`.

#### `wsgi`

Enables [Python][] applications support via [`mod_wsgi`][].

```yaml
apache_vhosts:
  'helldorado.info':
    wsgi:
      application_group: '%{GLOBAL}'
      process_group    : 'wsgi'
      daemon_process   :
        name   : 'wsgi'
        options:
          processes    : '2'
          threads      : '15'
          display-name : '%{GROUP}'
      import_script:
        path    : '/var/www//python-app/abstract.wsgi'
        options :
          process-group     : 'wsgi'
          application-group : '%{GLOBAL}'
      script_aliases: {/: '/var/www/python-app/appliance.wsgi', /combo: '/var/www/python-app/combo.wsgi'}
```

**Parameters within `wsgi`**:

- `application_group`: Sets which application group WSGI application belongs to via the module's [`WSGIApplicationGroup`](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIApplicationGroup.html) directive. **Valid options:** `%{GLOBAL}` , `%{SERVER}` , `%{RESOURCE}` , `%{ENV:variable}` or explicit name of your own choosing.
- `daemon_process`: Configure a distinct daemon process for running applications via the module's [`WSGIDaemonProcess`](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIDaemonProcess.html) directive.
   - `name`: The name of the daemon process. **Valid options:** `string`.
   - `options`: An `key: value` pair. **Valid options:** [`key: value from WSGIDaemonProcess `](http://modwsgi.readthedocs.org/en/latest/configuration-directives/WSGIDaemonProcess.html).
- `chunked_request`: Enables support for chunked requests via the module's [`WSGIChunkedRequest`](https://modwsgi.readthedocs.io/en/latest/configuration.html) directive. **Valid options:** `On` , `Off`.
- `import_script`: Specify a script file to be loaded on process start via the module's [`WSGIImportScript`](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIImportScript.html) directive.
   - `path`: Sets the path of script file to be loaded when a process starts. **Valid options:** `path`.
   - `options`: An `key: value` pair. **Valid options:** [`key: value from WSGIImportScript `](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIImportScript.html)
- `pass_authorization`: Enable/Disable passing of authorisation headers via the module's [`WSGIPassAuthorization`](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIPassAuthorization.html) directive. **Valid options:** `On` , `Off`.
- `process_group`: 	Sets which process group WSGI application is assigned to via the module's [`WSGIProcessGroup`](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIProcessGroup.html) directive. **Valid options:** `%{GLOBAL}` , `%{ENV:variable}`
- `script_aliases`: Maps a URL to a filesystem location and designates the target as a WSGI script via the module's [`WSGIScriptAlias`](https://modwsgi.readthedocs.io/en/latest/configuration-directives/WSGIScriptAlias.html) directive. **Valid options:** an [Hash](https://docs.ansible.com/ansible/YAMLSyntax.html) such as: `{/: '/var/www/python-app/appliance.wsgi', /combo: '/var/www/python-app/combo.wsgi'}`
