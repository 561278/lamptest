Changelog
=========

2.1.10 (2017-10-01)
-------------------
- Ensure log diretories created with custom user if needed -- See **MR** !28 from @jean.milot. [Abdoul Bah]
- **[DOC]** -  Rewritre howto use hashing. [Abdoul Bah]
- **[DOC]** -  Fix typo and oimitted link. [Abdoul Bah]
- Add boolean **`create`** documentroot path -- See **MR** !20 from @sebastien.stinkeste. [Abdoul Bah]
- Using **`%V`** instead **`v`** so ServerAlias name can handle in log -- See **MR** !25 from @thomas.guiseppin. [Abdoul Bah]
- Set default timeout in fastcgi wrapper to 30 instead 15 -- See **MR** !32. [Abdoul Bah]
- Rewrite **`mod_authz_core`** wokflow -- Fix #18 Closes #18. [Abdoul Bah]
- Fix #19 and Close #19 - AddType in fastcgi. Note this affect only OS < 9. [Abdoul Bah]


2.1.9 (2017-09-06)
-------------------
- Merge branch 'stretch-support' into 'master' [louis.billiet]

  Stretch support

  See merge request !33
- Add stretch support. [Abdoul Bah]
- Adding warning using mod_fastcgi in Debian Stretch. [Abdoul Bah]
- Update README integrate => Configure FastCGI servers to handle PHP
  files via [`mod_proxy_fcgi`][] [Abdoul Bah]
- Ensure role is Indepotent by settings an cache_valid_time. [Abdoul
  Bah]
- Adding FastCGI support for mod_proxy and with template and enable
  proxy and proxy_fcgi. [Abdoul Bah]
- Htpasswd: fix passlib module version comparison. [Abdoul Bah]
- Ensure when OS => Stretch packages name is apache2. [Abdoul Bah]
- Fix SSL security issue
- Fix some issues on units test


2.1.8 (2017-08-02)
------------------
- Merge branch 'various_fixes' into 'master' [abdoul.bah]

  Various fixes

  See merge request !31
- Suppress deprecation warning. [Louis Billiet]
- Fix pierre's problem. [Louis Billiet]
- Remove the fucken update-cache. [Louis Billiet]


2.1.7 (2017-07-31)
------------------
- Merge branch 'issue_14' into 'master' [abdoul.bah]

  Issue 14

  See merge request !30
- Fix issue 14. [Louis Billiet]


2.1.6 (2017-05-23)
------------------
- Add template mpm_* [pierre.boesch]


2.1.5 (2017-03-27)
------------------
- Merge branch 'include_main_conf' into 'master' [louis.billiet]

  Adding support for custom include directories in main conf

  See merge request !27
- Improve support include custom directories. [abdoul.bah]
- Fix integration issue in MR #26. [abdoul.bah]
- Update CHANGELOG. [abdoul.bah]


2.1.4 (2017-03-14)
------------------
- Support include directories in main apache conf. Update the test and
  README related to te new functionnality. [abdoul.bah]


2.1.3 (2017-01-30)
------------------

New
---
- Customize Badbots User-agent. close #10. [sebastien.stinkeste]

Fix
---
- Remove cache_valid_time. [Louis Billiet]

Other
-----
- Merge branch 'include-conf-enable' into 'master' [abdoul.bah]

  Add conf-enabled directory to apache.conf

  See merge request !24
- Add /etc/apache2/conf-enabled/ directory to apache.conf template +
  correct exemple redirect syntax of apache_vhosts. [Pierre Boesch]
- Merge branch 'badbot' into 'master' [nicolas.berthe]

  User-agent setting. close #10

  User-agent setting

  See merge request !19
- Merge branch 'redmine4094' into 'release2.0.0' [nicolas.berthe]

  remove cache_valid_time

  http://redmine.nexen.net/issues/4094

  See merge request !18
- Merge branch 'updateKitchen' into 'release2.0.0' [nicolas.berthe]

  write complete test suites



  See merge request !17
- Tests for debian and ubuntu OK. [Louis Billiet]


2.1.1 (2016-09-09)
------------------
- Fix template expires if apache_modules is undefined. [Nicolas Berthe]
- Manually merge disableOverrideFPMStatus into release2.0.0. [Nicolas
  Berthe]
- Repair SSL files copy. [Louis Billiet]
- Repair NameVirtualHost. [Louis Billiet]
- Remove vhosts installed by package for wheezy. [Louis Billiet]
- Remove unauthorized AllowOverride. [Louis Billiet]
- Add NameVirtualHost * for apache 2.2. [Louis Billiet]
- Disable htaccess and rewrite engine for fpm-{ping,status} [Louis
  Billiet]
- Add php5 in mod_no_template. [Louis Billiet]
- Add RewriteOptions directive. [Louis Billiet]
- Merge branch 'improvements' into 'release2.0.0' [nicolas.berthe]

  Improvements

  - repair vhosts multiplexing for apache 2.2 :
      When installing apache 2.2, it would serve only the default vhost provided by the package.
  - add rewrite_options to template :
      Feature asked by a client that wasn't implemented yet.
  - disable rewrite engine for fpm status/ping path :
      Rewrite rules in .htaccess files could rewrite urls for fpm-status and fpm-ping, preventing polling through apache.

  See merge request !13
- Repair SSL files copy. [Louis Billiet]
- Repair vhosts multiplexing for apache 2.2. [Louis Billiet]
- Add rewrite_options to template. [Louis Billiet]
- Disable rewrite engine for fpm status/ping path. [Louis Billiet]
- Add proxy_http module template. [Nicolas Berthe]
- Update CHANGELOG. [abdoul.bah]
- Update README. [abdoul.bah]
- Add custom template management. Poke Nicolas Berthe. [abdoul.bah]
- Update CHANGELOG. [abdoul.bah]


2.1.0 (2016-07-22)
------------------
- Update README. [abdoul.bah]
- Rename vars of security and add httpoxy mitigation. [abdoul.bah]
- Rename modsec to security. [abdoul.bah]
- Add mod_sec template. [abdoul.bah]
- Ensure user and group for test is created. [abdoul.bah]
- Fix mod_sec and add some rules, rewrite mod_jk, Add more tests...
  [abdoul.bah]
- Add suexec to apache_mod_no_template. [abdoul.bah]
- Add suexec to modules list. [abdoul.bah]
- Modify integration test. [abdoul.bah]
- Add wsgi module configuration. [abdoul.bah]
- Fix handler name. [abdoul.bah]
- Rewrite wsgi hash. [abdoul.bah]
- Rewrite vhosts macro for env hashes. [abdoul.bah]
- Fix test for Rewrite env hashes. [abdoul.bah]
- Add support for SSLProxyMachineCertificateChainFile. [abdoul.bah]
- Rename varaible no_proxy_uris to proxy_no_uris and
  no_proxy__uris_match to proxy_no_uris_match. [abdoul.bah]
- Rewrite env hashes. [abdoul.bah]
- Merge branch 'relectureReadme' into 'release2.0.0' [abdoul.bah]

  relecture du 11/07



  See merge request !12
- Relecture du 11/07. [Louis Billiet]
- Update CHANGELOG. [abdoul.bah]


2.0.10 (2016-07-08)
-------------------
- Add Passenger documentation in apache_vhosts hosts section.
  [abdoul.bah]
- Add support for PassengerGroup and PassengerMaxInstances in virtual
  host context. [abdoul.bah]
- Udpate Readme. [abdoul.bah]
- Merge branch 'syslog-error' into 'release2.0.0' [abdoul.bah]

  Fix ErrorLog syslog tags (error instead of access)

  CustomLog and ErrorLog were defined to use the same syslog tag in main.j2

  See merge request !11
- Fix ErrorLog syslog tags (error instead of access) [Samir Noir]
- Update CHANGELOG. [abdoul.bah]


2.0.9 (2016-07-08)
------------------
- Fix itk useridexpr groupidexpr vars name. [abdoul.bah]
- Update CHANGELOG.md. [abdoul.bah]


2.0.8 (2016-07-08)
------------------
- Update Readme. [abdoul.bah]


2.0.7 (2016-07-04)
------------------
- Update CHANGELOG. [abdoul.bah]
- Fix _directory.j2 name. [abdoul.bah]
- Update changelog. [Abdoul Bah]


2.0.6 (2016-06-29)
------------------
- Update Readme with full apache modules reference documentation.
  [Abdoul Bah]
- Add diretory support for managing Index index_redirect check_handler
  and slash. [Abdoul Bah]
- Update CHANGELOG. [Abdoul Bah]
- Update CHANGELOG. [Abdoul Bah]


2.0.5 (2016-06-28)
------------------
- Update CHANGELOG. [Abdoul Bah]
- Merge branch 'mpm-event' into 'release2.0.0' [abdoul.bah]

  Fix MPM Event configuration (MaxRequestWorkers)

  And remove some trailings tabs.

  See merge request !9
- - Fix MPM Event configuration (MaxRequestWorkers) - Remove trailing
  tabs. [Samir Noir]


2.0.4 (2016-06-28)
------------------
- Fix mpm events issue and apache_modules not require for configure the
  MPM modules (Fix #7 and  Closes #7) [Abdoul Bah]
- Update CHANGELOG. [Abdoul Bah]
- Ensure disable_root on userdir is boolean. [Abdoul Bah]
- ExtendedStatus defaulted to On, to ensure fetch all informations
  needed by some metrics appliance. [Abdoul Bah]
- Add .gitchangelog config. [Abdoul Bah]
- Add Changelog. [Abdoul Bah]


2.0.3 (2016-05-26)
------------------
- Add support for htpassword. [Abdoul Bah]
- Merge branch 'repairKitchen' into 'release2.0.0' [abdoul.bah]

  Repair kitchen

  Containers provisionning failed because debian is not shipped with non-free sources by default.

  See merge request !8
- Provision containers with git and non-free sources. [Louis Billiet]
- Fix handlers name. [Abdoul Bah]
- Fix scm issue and add dot files support. [Abdoul Bah]
- Fix Apache2.4 directives name. [Abdoul Bah]
- Fix YAML syntax. [Abdoul Bah]
- Implemente @antonio.moscato 54ff840 X-Apache-Server-ID and X-Vhost-ID
  with full support SetEnv for security. [Abdoul Bah]
- Fix Issue #6 Close Issue #6. [Abdoul Bah]
- Add MaxSpareProcessors for peruser MPM. [Abdoul Bah]
- Fix proxy request issue. [Abdoul Bah]
- Fix proxy request issue. [Abdoul Bah]
- Update README and Fix pagespeed undifined vars. [Abdoul Bah]


2.0.2 (2016-05-16)
------------------
- Push the securtiy template. [Abdoul Bah]


2.0.1 (2016-05-16)
------------------
- Add support for blocking SCM and update README. [Abdoul Bah]
- Fix issue from redmine http://redmine.nexen.net/issues/3790. [Abdoul
  Bah]
- Update README. [Abdoul Bah]
- Merge branch 'relecture' into 'release2.0.0' [abdoul.bah]

  Relecture



  See merge request !7
- Fallbackressource. [Antonio Moscato]
- Fallbackressource. [Antonio Moscato]
- Coquille. [Antonio Moscato]
- Petit test. [Antonio Moscato]
- Update README. [Abdoul Bah]
- Update README. [Abdoul Bah]
- Update readme. [Abdoul Bah]
- Remove installing modules from vhosts dict. [Abdoul Bah]
- Fix #4 and update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Fix mandatory apache_badbot. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Readme. [Abdoul Bah]
- Fix some issue Add badbot and update logging management Disable
  ExtendedStatus by default for performance issue Update Readme. [Abdoul
  Bah]


2.0.0 (2016-05-04)
------------------
- Fix servername interpolation when servername is not defined. [Abdoul
  Bah]
- .... Ref f4d3df10 and add mode fix Issue #3. [Abdoul Bah]
- Fix all http://redmine.nexen.net/issues/3764 and Fix Issue #2. [Abdoul
  Bah]
- Fix Issue #2 Close Issue #2. [Abdoul Bah]
- Clean up. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Fix missed Jessie vars file and update Readme. [Abdoul Bah]
- Update Readme. [Abdoul Bah]
- Add Jessie missed add on bump commit. [Abdoul Bah]
- Add ommited files ^^ [Abdoul Bah]
- Fix readme. [Abdoul Bah]
- Bump version 2.0.0. [Abdoul Bah]


1.0.1 (2016-04-14)
------------------
- Merge branch 'v1.0.1' into 'master' [Nicolas BERTHE]

  Update v1.0.1



  See merge request !6
- Update v1.0.1. [Nicolas Berthe]


1.0.0 (2016-03-16)
------------------
- Fix main.yml. [Jonathan Lestrelin]
- Merge branch 'nb_correctifs' into 'master' [Jonathan Lestrelin]

  Prise en compte de Ubuntu/Utopic

  See merge request !3
- Prise en compte de Ubuntu/Utopic. [Nicolas Berthe]
- Merge branch 'apache-2.4' into 'master' [jonathan.lestrelin]

  Apache 2.4

  Configuration pour Ubuntu / Apache 2.4
  :hash: J'ai juste un soucis sur la conf apache avec syslog

  See merge request !2
- Hormis syslog apache tout ok. [HeL]
- Typo dans user-site-2.2.yml. [HeL]
- Initial commit. [HeL]
- Fix Keepalived under proxy settings. [abdoul.bah]
- Add build status. [nicolas.vogel]
- Add test for prefork. [nicolas.vogel]
- Remove log file. [nicolas.vogel]
- Gestion du mod fastcgi. [nicolas.vogel]
- Remove check apt. [nicolas.vogel]
- Activate non free. [nicolas.vogel]
- Activate non free. [nicolas.vogel]
- Activate non free. [nicolas.vogel]
- Enable à True par défaut. [nicolas.vogel]
- Add test for lib. [nicolas.vogel]
- Add test for rpaf. [nicolas.vogel]
- Add test lib. [nicolas.vogel]
- Add test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Update test. [nicolas.vogel]
- Add test. [nicolas.vogel]
- Add test. [nicolas.vogel]
- Add test. [nicolas.vogel]
- Gestion des vhosts. [nicolas.vogel]
- Gestion des vhosts. [nicolas.vogel]
- Gestion des mods. [nicolas.vogel]
- Gestion des mods. [nicolas.vogel]
- Add comment. [nicolas.vogel]
- Manage mod. [nicolas.vogel]
- Manage mod. [nicolas.vogel]
- Manage mod. [nicolas.vogel]
- Manage mod. [nicolas.vogel]
- Manage mod. [nicolas.vogel]
- Manage mod. [nicolas.vogel]
- Manage lib. [nicolas.vogel]
- Manage lib. [nicolas.vogel]
- Manage lib. [nicolas.vogel]
- Dot not manage php file. [nicolas.vogel]
- Definition du pool par défaut. [nicolas.vogel]
- Fix status. [nicolas.vogel]
- Add status. [nicolas.vogel]
- Refaction fastcgi. [nicolas.vogel]
- Changement de la banniere des fichiers de template. [nicolas.vogel]
- Changement de la banniere des fichiers de template. [nicolas.vogel]
- Fix default value. [nicolas.vogel]
- Valeur par defaut. [nicolas.vogel]
- Mise à jour de la documentation. [nicolas.vogel]
- Rename default vhost. [nicolas.vogel]
- Disable vhost. [nicolas.vogel]
- Manage user vhost. [nicolas.vogel]
- Add sub task file for default vhost. [nicolas.vogel]
- Fix condition. [nicolas.vogel]
- Add comments. [nicolas.vogel]
- Fix variable name :: nvogel compliant. [abdoul.bah]
- Add Logformat section and control KeepAlive and X-Forwarded-For if
  under proxy. [abdoul.bah]
- Fix variable name. [nicolas.vogel]
- Fix varaible name. [nicolas.vogel]
- Add ports.conf. [nicolas.vogel]
- Remove defaut index file. [nicolas.vogel]
- Change default file. [nicolas.vogel]
- Change order. [nicolas.vogel]
- Add spec test. [nicolas.vogel]
- Add default page. [nicolas.vogel]
- Add defaut page when php is used. [nicolas.vogel]
- Fix test. [nicolas.vogel]
- Fix default document root directory name. [nicolas.vogel]
- Mange default vhost. [nicolas.vogel]
- Fix test. [nicolas.vogel]
- Add comment. [nicolas.vogel]
- Add a loop for fastcgi. [nicolas.vogel]
- Add a loop for fastcgi. [nicolas.vogel]
- Add a loop for fastcgi. [nicolas.vogel]
- Change defaut pool. [nicolas.vogel]
- Change fastcgi.conf. [nicolas.vogel]
- Change fastcgi.conf. [nicolas.vogel]
- Add rspec test. [nicolas.vogel]
- Fix spec test. [nicolas.vogel]
- Fix spec test. [nicolas.vogel]
- Fix spec test. [nicolas.vogel]
- Fix spec test. [nicolas.vogel]
- Fix spec test. [nicolas.vogel]
- Fix space. [nicolas.vogel]
- Add fastcgi.conf file. [nicolas.vogel]
- Add spec test. [nicolas.vogel]
- Add spec test. [nicolas.vogel]
- Fix action. [nicolas.vogel]
- Add test en activate module. [nicolas.vogel]
- Add check on worker. [nicolas.vogel]
- Add check on worker. [nicolas.vogel]
- Fix variable name for check port. [nicolas.vogel]
- Install fastcgi when needed. [nicolas.vogel]
- Change variable name for check_port. [nicolas.vogel]
- Documentation des variables. [nicolas.vogel]
- Commenter les variables. [nicolas.vogel]
- Initialisation de la documentation et de la partie tests.
  [nicolas.vogel]
- Remove .rspec file. [nicolas.vogel]
- Add serverspec tests. [nicolas.vogel]
- Add security file. [nicolas.vogel]
- Fix confd var. [abdoul.bah]
- Code and vars refactoring. [abdoul.bah]
- Add security default file. [nicolas.vogel]
- Fix apache.conf.j2 path and name. [abdoul.bah]
- Configure apache default conf and reload. [abdoul.bah]
- Ajout du template apache2.conf.j2. [nicolas.vogel]
- Add check apache listening in default port. [abdoul.bah]
- Fix variable name. [nicolas.vogel]
- Install worker by default. [nicolas.vogel]
- Init task file. [nicolas.vogel]
- Init awh-apache. [abdoul.bah]


