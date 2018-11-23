Changelog
=========

%%version%% (unreleased)
------------------------

New
~~~

- Add ignore_db_dir variables. close #6. [sebastien.stinkeste]

Changes
~~~~~~~

- Update test-kitchen to use ansible 2.1 & normalize. [Nicolas Berthe]

Fix
~~~

- Query_cache_type is absent. close #9. [Nicolas Berthe]

1.0.5 (2016-09-22)
------------------

Fix
~~~

- Fix asserts name. [sebastien.stinkeste]

- Fix default mysql_version string quote. [nicolas.berthe]

1.0.4 (2016-07-04)
------------------

New
~~~

- Add Full CHANGELOG and mv features information in LATEST_FEATURES.
  [abdoul.bah]

- Add tasks that installs oracle repository. [Louis Billiet]

Changes
~~~~~~~

- Update to release 1.0.4 (rc4) [Nicolas Berthe]

Fix
~~~

- Fix Mariadb repository unavalaible. Using CNRS respository. Cf =>
  [Abdoul Bah]

1.0.3 (2016-04-29)
------------------

Fix
~~~

- Fix tag name and add query_cache_type support. [Abdoul Bah]

1.0.2 (2016-04-29)
------------------

Fix
~~~

- Fixes for ansible v2 and comment /etc/host change for replication.
  [stephane.pecourt]

1.0.1 (2016-04-14)
------------------

New
~~~

- Add Clustering. [abdoul.bah]

- Add Cluster futures. [abdoul.bah]

- Add backup and host_vars. [abdoul.bah]

- Add Replication mode and backup. [abdoul.bah]

- Add Rspec test suite. [abdoul.bah]

- Add Support for LVM. [Vincent Bolinard]

- Add a variable and a handler to restart MySQL if the configuration
  changes. [Vincent Bolinard]

Changes
~~~~~~~

- Update main.yml. [Jonathan Lestrelin]

- Update test and path. [herve.leclerc]

Fix
~~~

- Fixes meta for ansible v2. [stephane.pecourt]

- Fix #4 close #4. [abdoul.bah]

- Fix fecth debian.cnf error. [abdoul.bah]

- Fix fecth debian.cnf error. [abdoul.bah]

- Fix table_open_cache for 5.6 version. [abdoul.bah]

- Fix Rspec variable name. [abdoul.bah]

- Fix Rspec variable name. [abdoul.bah]

- Fix Rspec path. [abdoul.bah]

- Fix a typo. [Vincent Bolinard]


