MYSQL ![ansible-mysql](https://img.shields.io/badge/ansible-apache-ff69b4.svg) [![pipeline status](https://git.alterway.fr/ansibleroles/awh-mysql/badges/master/pipeline.svg)](https://git.alterway.fr/ansibleroles/awh-mysql/commits/master)
================

## Description

This role install and configure **Mysql Server**.

Providers available :  `MariaDB`, `Percona` and `Oracle`

Modes available : `standalone`, `replication` and `cluster`

## Requirement

-   ![Mysql](https://img.shields.io/badge/Ansible->=2.2-blue.svg)

## Mysql Versions & Providers available

| Provider          | Version                     |
|-------------------|-----------------------------|
|Percona            |  `5.5`,`5.6`,`5.7`          |
|Oracle             |  `5.5`,`5.6`,`5.7`          |
|MariaDB            |  `5.5`,`10.0`,`10.1`,`10.2` |
|Percona (Cluster)  |  `5.6` , `5.7`              |
|MariaDB (Cluster)  |  `10.0`, `10,1`, `10.2`     |

## Default repository

This role auto-select repository.

It's possible to use a custom repository with `mysql_custom_repo` variable :

**Example**:

   ```yaml
   mysql_custom_repo:
     'myreponame':
       url          : 'http://repo.mysql.com/apt/debian'
       distribution : 'jessie'
       section      : 'mysql-5.7'
       state        : 'present'
       keyserver    : 'keyserver.ubuntu.com'
       id           : '8C718D3B5072E1F5'
       pin          : 'version 5.7.*'
       pin_packages : 'mysql-*'
       pin_priority : 990
   ```
## Version vs OS matrix.

> If you go out of this matrix, no guarantee of operation is given.

| Provider  | Version    |Debian Wheezy|Debian Jessie|Debian Stretch|Ubuntu Trusty|Ubuntu Xenial| Centos 6 | Centos 7 |
|-----------|------------|------|------|------|------|------|------|------|
|Percona    | 5.5         |    √ |    √ | √  |    √ |    √ |      |      |   
|Percona    | 5.6         |    √ |    √ | √  |    √ |    √ |      |      |   
|Percona    | 5.7         |    √ |    √ | √  |    √ |    √ |      |      |   
|Oracle     | 5.5         |    √ |    √ |  :x: |   √   |  √    |      |      |   
|Oracle     | 5.6         |    √ |    √ |  :x: |    √ |  √    |      |      |   
|Oracle     | 5.7         |    √ |    √ | :x:  |    √ |    √ |      |      |   
|MariaDB    | 5.5         |    √ |    :x:  | :x:  |    :x: |      |      |      |   
|MariaDB    | 10.0        |    √ |    √ | :x:  |   √ |    √ |      |      |   
|MariaDB    | 10.1        |    √ |    √ | √  |   √ |    √ |      |      |   
|MariaDB    | 10.2        |    √ |    √ | √  |   √ |    √ |      |      |  
|Percona Cluster | 5.6    |    √ |    √ | :x:  |   √ |    √ |      |      |
|Percona Cluster | 5.7    |    √ |    √ | √  |   √ |    √ |      |      |
|MariaDB Cluster | 10.0   |    √ |    √ | :x:  |   √ |    √ |      |      |
|MariaDB Cluster | 10.1   |    √ |    √ | √  |   √ |    √ |      |      |  
|MariaDB Cluster | 10.2   |    √ |    √ | √  |   √ |    √ |      |      |  



## Tags

|TAGS                                  |DESCRIPTION                                                     |
|--------------------------------------|----------------------------------------------------------------|
|mysql                                 | Limit to execute all tasks of this roles |
|mysql_install                         | Limit to execute **installation tasks** |
|mysql_configuration                   | Limit to execute **configuration tasks** (global & replication & cluster) |
|mysql_replication                     | Limit to execute **replication tasks** |
|mysql_cluster                         | Limit to execute **cluster tasks** |

## Variables

### Global

|VARIABLES                                  |  TYPES |REQUIRE|DEFAULT                 |DESCRIPTION       |
|-------------------------------------------|--------------|------|------------------------|------------------|
|mysql_version                              |  STRING       |  NO  |    10.2               | Version of Mysql |
|mysql_provider                             |  STRING (`percona`,`mariadb`,`oracle`)      |  NO  |   mariadb           | Provider of Mysql |
|mysql_include                              |  HASH         | NO      | | Hashes of included dir and dest files |
|mysql_custom_template                      |  STRING(PATH) | NO      | | Use custom template instead yaml `key: value` |
|mysql_root_password                        |  STRING       |  **YES**  |             ||
|mysql_bind_iface                           |  STRING       |  NO     |  ansible_default_ipv4.interface        ||
|mysql_port                                 |  NUMBER       |  NO     |  3306           ||
|mysql_bind_address                         |  STRING       |  NO     |  127.0.0.1      ||
|mysql_socket                               |  STRING       |  NO     |  /var/run/mysqld/mysqld.sock           ||
|mysql_nice                                 |  NUMBER       |  NO     |  0           ||
|mysql_pid                                  |  STRING       |  NO     |  /var/run/mysqld/mysqld.pid           ||
|mysql_basedir                              |  STRING       |  NO     |  /usr           ||
|mysql_datadir                              |  STRING       |  NO     |  /var/lib/mysql           ||
|mysql_tmpdir                               |  STRING       |  NO     |  /tmp           ||
|mysql_user                                 |  STRING       |  NO     |  mysql           ||
|mysql_max_allowed_packet                   |  STRING       |  NO     |  16M           ||
|mysql_expire_logs_days                     |  NUMBER       |  NO     |  1           ||
|mysql_max_binlog_size                      |  STRING       |  NO     |  100M           ||
|mysql_myisam_recover                       |  BOOLEAN      |  NO     |  false           ||
|mysql_general_logging                      |  STRING       |  NO     |  /var/log/mysql/mysql.log           ||
|mysql_log_error_type                       |  STRING       |  NO     |  syslog           ||
|mysql_log_error_file                       |  STRING       |  NO     |  /var/log/mysql/mysql-error.log           ||
|mysql_slow_queries_logging                 |  STRING       |  NO     |  false           ||
|mysql_slow_queries_log_file                |  STRING       |  NO     |  /var/log/mysql/mysql-slow.log           |||
|mysql_long_query_time                      |  NUMBER       |  NO     |  10           ||
|mysql_log_queries_not_using_indexes        |  STRING       |  NO     |  false        ||
|mysql_log_bin_trust_function_creators      |  BOOLEAN      |  NO     |  false        ||
|mysql_sync_binlog                          |  INT          |  NO     |  0            |More info [sync_binlog](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog)|
|mysql_open_files_limit                     |  NUMBER       |  NO     |  102400       ||
|mysql_key_buffer_size                      |  STRING       |  NO     |  128M       ||
|mysql_table_open_cache                     |  NUMBER       |  NO     |  400        ||
|mysql_connect_timeout                      |  NUMBER       |  NO     |  5          ||
|mysql_lc_messages_dir                      |  STRING       |  NO     |  /usr/share/mysql ||
|mysql_wait_timeout                         |  NUMBER       |  NO     |  600        ||
|mysql_sort_buffer_size                     |  STRING       |  NO     |  4M         ||
|mysql_bulk_insert_buffer_size              |  STRING       |  NO     |  16M        ||
|mysql_tmp_table_size                       |  STRING       |  NO     |  32M     ||
|mysql_max_heap_table_size                  |  STRING       |  NO     |  32M     ||
|mysql_myisam_sort_buffer_size              |  STRING       |  NO     |  512M     ||
|mysql_concurrent_insert                    |  NUMBER       |  NO     |  2     ||
|mysql_read_buffer_size                     |  STRING       |  NO     |  2M     ||
|mysql_read_rnd_buffer_size                 |  STRING       |  NO     |  1M     ||
|mysql_log_warnings                         |  NUMBER       |  NO     |  2     ||
|mysql_myisam_repair_threads                |  NUMBER       |  NO     |  16     ||
|mysql_key_buffer                           |  STRING       |  NO     |  16M     ||
|mysql_thread_stack                         |  STRING       |  NO     |  192K     ||
|mysql_thread_cache_size                    |  STRING       |  NO     |  128     ||
|mysql_max_connections                      |  NUMBER       |  NO     |  100     ||
|mysql_table_cache                          |  NUMBER       |  NO     |  64     ||
|mysql_query_cache_type                     |  NUMBER       |  NO     |  1     ||
|mysql_query_cache_limit                    |  STRING       |  NO     |  1M     ||
|mysql_query_cache_size                     |  STRING       |  NO     |  16M     ||
|mysql_innodb_file_per_table                |  NUMBER       |  NO     |  1           ||
|mysql_innodb_buffer_pool_size              |  STRING       |  NO     |  256M        ||
|mysql_innodb_log_file_size                 |  STRING       |  NO     |  128M        ||
|mysql_innodb_log_buffer_size               |  STRING       |  NO     |  8M          ||
|mysql_innodb_thread_concurrency            |  NUMBER       |  NO     |  4           ||
|mysql_innodb_read_io_threads               |  NUMBER       |  NO     |  2           ||
|mysql_innodb_write_io_threads              |  NUMBER       |  NO     |  2           ||
|mysql_innodb_file_per_table                |  STRING       |  NO     |  NO          ||
|mysql_innodb_open_files                    |  NUMBER       |  NO     |  400         ||
|mysql_innodb_io_capacity                   |  NUMBER       |  NO     |  600         ||
|mysql_innodb_lock_wait_timeout             |  NUMBER       |  NO     |  60          ||
|mysql_innodb_flush_method                  |  STRING       |  NO     |  O_DIRECT    ||
|mysql_innodb_doublewrite                   |  STRING       |  NO     |  0           ||
|mysql_innodb_use_native_aio                |  STRING       |  NO     |  1           ||
|mysql_innodb_flush_log_at_trx_commit       |  NUMBER       |  NO     |  1           ||
|mysql_default_storage_engine               |  STRING       |  NO     |  InnoDB      ||
|mysql_custom_repo                          |  DICT         |  NO  |  undefined       | Define custom repository |
|mysql_xtrabackup_files_limit               |  NUMBER       |  NO     |  2000        | Avoid xtrabackup crash from bareos beacause of too many open files     ||


### Replication

|VARIABLES                                  |  TYPES |REQUIRE|DEFAULT                 |DESCRIPTION       |
|-------------------------------------------|--------------|------|------------------------|------------------|
|mysql_replication                          |  BOOLEAN      |  NO     |  false      ||
|mysql_replication_role                     |  STRING (`master`,`slave`) |  **YES**     |     ||
|mysql_replication_master                   |  STRING       |  **YES**     |     ||
|mysql_replication_slaveof                  |  STRING       |  NO     |     |Make Master instance a copy of another instance|
|mysql_replication_server_id                |  NUMBER       |  NO     |  1      ||
|mysql_log_bin                              |  STRING       |  NO     |  /var/log/mysql/mysql-bin.log      ||
|mysql_binlog_format                        |  STRING       |  NO     |  ROW      ||
|mysql_binlog_do_db                         |  ARRAY        |  NO     |  []      ||
|mysql_replicate_do_db                      |  ARRAY        |  NO     |  []      ||
|mysql_binlog_ignore_db                     |  ARRAY        |  NO     |  []      ||
|mysql_replicate_ignore_db                  |  ARRAY        |  NO     |  []      ||
|mysql_relay_log                            |  STRING       |  NO     |  /var/log/mysql/relay-bin      ||
|mysql_relay_log_index                      |  ARRAY        |  NO     |  /var/log/mysql/relay-bin.index      ||
|mysql_fetch_dir                            |  STRING       |  NO  |  files           ||
|mysql_conf_dir                             |  STRING       |  NO  |  /etc/mysql           ||
|mysql_slave_readonly                       |  STRING       |  NO  |  1           | Set the readonly value to On if master/slave, or Off if master/master case only if mysql_replication_role is defined as slave |
|mysql_gtid_mode                            |  STRING       |  NO  |             | Set GTID mode on master and slave, also set other needed parameters for GTID to work. Available values can change between version, please see MySQL documentation |

### Cluster

|VARIABLES                                  |  TYPES |REQUIRE|DEFAULT                 |DESCRIPTION       |
|-------------------------------------------|--------------|------|------------------------|------------------|
|mysql_cluster_enabled                      |  BOOLEAN       |  NO  |  false       | Enable CLUSTER (Ansible tasks)   |
|mysql_wsrep_on                             |  STRING        |  NO  |  'TRUE'      | Enable CLUSTER (Service) |
|mysql_cluster_user                         |  STRING        |  NO  |  'cluster_adm' | Enable CLUSTER (User sst auth & xinetd) |
|mysql_cluster_password                     |  STRING        |  **YES**  |       | Cluster Password (Password sst auth & xinetd) |
|mysql_cluster_host                         |  STRING        |  NO  |  '%' | Network allow for xinetd auth |
|mysql_cluster_network                      |  STRING        |  NO  |  '0.0.0.0'        | mysqlchk listen network |
|mysql_cluster_xinetd_port                  |  NUMBER        |  NO  |  9500             | mysqlchk listen port  |
|mysql_cluster_available_donor              |  NUMBER        |  NO  |  2               ||
|mysql_wsrep_provider_options               |  STRING        |  NO  |  'gcache.size=256M'       | Provider Options. |
|mysql_wsrep_replicate_myisam               |  STRING        |  NO  |  'FALSE'                 |  |
|mysql_wresp_node_address                   |  STRING        |  NO  |  "{{ hostvars[inventory_hostname]['ansible_' + mysql_bind_iface]['ipv4']['address'] }}" |  |
|mysql_wsrep_sst_method                     |  STRING(`xtrabackup`,`xtrabackup-v2`) |  NO  |  'xtrabackup-v2' | |
|mysql_wsrep_sst_auth                       |  STRING        |  NO  | "{{mysql_cluster_user}}:{{mysql_cluster_password}}"   | only use if mysql_wsrep_sst_method = xtrabackup or xtrabackup-v2 |
|mysql_wsrep_slave_threads                  |  NUMBER        |  NO  |  2                 |  |
|mysql_wsrep_cluster_name                   |  STRING        |  NO  |  'mysql_cluster'                 |  |
|mysql_wsrep_cluster_members                |  ARRAY/LIST    |  YES  |  | List of `hostname` - members cluster  |
|mysql_wsrep_raw                            |  DICT          |  NO |  {}   | optionnal dict key/value extend block  |
|mysql_log_bin                              |  STRING        |  NO     |  /var/log/mysql/mysql-bin.log      ||
|mysql_binlog_format                        |  STRING        |  NO     |  ROW      ||
|mysql_binlog_do_db                         |  ARRAY         |  NO     |  []      ||
|mysql_replicate_do_db                      |  ARRAY         |  NO     |  []      ||
|mysql_binlog_ignore_db                     |  ARRAY         |  NO     |  []      ||
|mysql_replicate_ignore_db                     |  ARRAY         |  NO     |  []      ||

### Extra Variables

Use this variables with extra-data :

|VARIABLES                                  |  TYPES |REQUIRE|DEFAULT                 |DESCRIPTION       |
|-------------------------------------------|--------------|------|------------------------|------------------|
|mysql_reinstall                            |  BOOLEAN       |  NO     |  false      | Force install tasks (Warning, this cleanup logfiles & restart service) |
|mysql_configuration                        |  BOOLEAN       |  NO     |  false      | Execute Configuration Tasks (Warning, this restart service) |
|mysql_has_restart                          |  BOOLEAN       |  NO     |  true       | Perform all tasks with a mysql service restart |


### QuickStart

### Install role

Add in your `requirements.yml` file :

   ```yaml
   - src: git+ssh://git@git.alterway.fr/ansibleroles/awh-mysql.git
     version: 1.0.14 # change this to latest version
     name: mysql
   ```

and use `ansible-galaxy` command line :

```bash
ansible-galaxy -r requirements.yml install -i -p roles/
```



### Howto use (minimal requirement)

#### Standalone

Just add variables :
   ```yaml
   mysql_version: 10.2
   mysql_version: 'mariadb'
   mysql_root_password: 'yours3cretP@SSword'
   ```

#### Replication
##### Master/Slave
  - On the **Master** and **Slave**:

    Enable replication with `mysql_replication: true`.

    Add `mysql_root_password`, `mysql_replication_user` and `mysql_replication_master` variables.

    You must allow mysql to listen your network for the slave(s) with `mysql_bind_address` variable.

       ```yaml
       mysql_replication: true
       mysql_bind_address: 0.0.0.0
       mysql_replication_master: 'mymaster' # Warning, check if slave dnslookup master ...
       mysql_root_password: 'yours3cretP@SSword'
       mysql_replication_user:
         name : 'replication'
         host : '10.12.%'        # change for your network.
         pass : 'repsecret'
       ```

  - On the **Master**:

    Define `mysql_replication_role` to `master`

        mysql_replication_role: master

  - On the **Slave(s)**:

    Define `mysql_replication_role` to `slave` and define the replication `id` of the slave :

      ```yaml
      mysql_replication_role: slave
      mysql_replication_server_id: 2
      ```

##### Master/Master
  - On the **two nodes**: Use Ansible [group_vars](http://docs.ansible.com/ansible/latest/intro_inventory.html#group-variables)

    - Enable replication with `mysql_replication: true`.
    - Set replication role to master on both node with `mysql_replication_role: master`
    - Add `mysql_root_password`, `mysql_replication_user` variables.

    You must allow mysql to listen your network for the slave(s) with `mysql_bind_address` variable.

       ```yaml
       mysql_replication: true
       mysql_bind_address: 0.0.0.0
       mysql_replication_role: master   
       mysql_root_password: 'yours3cretP@SSword'
       mysql_replication_user:
         name : 'replication'
         host : '10.12.%'        # change for your network.
         pass : 'repsecret'
       ```

  - On the **First Node**: Use Ansible [host_vars](http://docs.ansible.com/ansible/latest/intro_inventory.html#host-variables)

    - Define `mysql_replication_slaveof` to `mysql-second-node FDQN or IP` and define increment values.

      ```yaml
      mysql_replication_slaveof: mysql-second-node FQDN OR IP
      mysql_auto_increment_increment: 2
      ```

  - On the **Second Node**: Use Ansible [host_vars](http://docs.ansible.com/ansible/latest/intro_inventory.html#host-variables)

    - Define `mysql_replication_slaveof` to `mysql-first-node FDN OR IP`, define the replication `id` of the slave and define increment values:

      ```yaml
      mysql_replication_slaveof: mysql-first-node FQDN OR IP
      mysql_replication_server_id: 2
      mysql_auto_increment_increment: 2
      mysql_auto_increment_offset: 2
      ```
   > If you use **FQDN** on **`mysql_replication_slaveof`**,  please ensure both node dnslookup other...

#### Cluster

  The Cluster mode is available for **Mariadb** starting `10.0` and **Percona** starting `5.6`.

  Enable cluster with `mysql_cluster_enabled: true`.

  Add cluster credentials with `mysql_root_password` and `mysql_cluster_password` variables.

  Define the bootstrap node with `mysql_cluster_init_node` variable.

  Finally, add `mysql_wsrep_cluster_members` list with the `hostname` of nodes

   ```yaml
   mysql_cluster_enabled: true
   mysql_bind_address: 0.0.0.0
   mysql_root_password: 'yours3cretP@SSword'
   mysql_cluster_password: 'yourClusterP@SSword'
   mysql_cluster_init_node: myfirstnode
   mysql_wsrep_cluster_members:
     - myfirstnode
     - mysecondnode
     - mythirdnode
   ```

## Include custom configuration directories in mysql main configuration

Create directories and compile associated template or file.

```yaml
mysql_include:
  - src: test/datas/mysql/security.cnf.j2
    dest: awh.d/security.cnf
  - src: test/datas/mysql/go-play-elsewhere.cnf.j2
    dest: /etc/mysql/hell.d/go-play-elsewhere.cnf
  - src: test/datas/mysql/client.cnf.j2
    dest: /var/www/mysql/client.cnf
```
> :information_source: `dest` can be relative or absolute path form `/etc/mysql`. In example above, `awh.d/security.cnf` will be created on `/etc/mysql/awh.d/security.cnf` and `/var/www/mysql/client.cnf` in the absolute path.

## Licence

MIT view [LICENSE](LICENSE)

## Credits

 - Abdoul Bah <abdoul.bah@alterway.fr>
 - Nicolas BERTHE <nicolas.berthe@alterway.fr>
 - Stéphane PECOURT <stephane.pecourt@alterway.fr>
 - Louis Billiet <louis.billiet@alterway.fr>


## TODO

 - add `automysqlbackup`.
 - add `gardb`(Galera Arbitrator).
