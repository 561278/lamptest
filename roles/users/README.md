USERS (AWH) ![Electon-Orchestrator](https://img.shields.io/badge/electron-orchestrator-ff69b4.svg)
================

Role Ansible pour la gestion des users
 - SYSTEM
 - MYSQL
 - POSTGRESQL
 - MONGODB


## Sommaire

* [Description](#description)
* [Prerequis](#prerequis)
* [Variables](#variables)
* [Dictionnaires](#dictionnaires)
* [Dependances](#dependances)
* [QuickStart](#QuickStart)
  - [Installation et configuration](#installation-et-configuration)
  - [Exemple complet Playbook](#exemple-playbook)
  - [Tips](#tips)
* [Exemples](#exemples)
* [Developpement](#developpement)
* [Credits](#credits)
* [Licence](#licence)
* [References](#references)


Description
-----------
Ce role permet le management des users
 - **SYSTEM**
    - USER
    - GROUP
    - SUDO
    - SSH KEYS
    - AUTHORIZED KEYS

 - **MYSQL**
    - CREATE DATABASE
    - CRAETE USER & SET PRIVILEGES

 - **POSTGRESQL**
    - CREATE DATABASE
    - CRAETE USER & SET PRIVILEGES
    - SET EXETENDEND PRIVILEGES

 - **MONGODB**
    - CREATE DATABASE
    - CRAETE USER & SET PRIVILEGES

Versions
--------
Les versions supportées sont:

  ![Linux](https://img.shields.io/badge/Linux-all-blue.svg)
  ![MYSQL](https://img.shields.io/badge/mysql-5.1--5.6-blue.svg)
  ![MYSQL](https://img.shields.io/badge/postgresql-9.0--9.4-blue.svg)
  ![MONGODB](https://img.shields.io/badge/mongodb-2.0--3.X.Y-blue.svg)


Prerequis
---------

☕️ OR 🍻


Variables
---------


    VARIABLES                       TYPES/VALEURS      REQUIS    DEFAULT       DESCRIPTION
    ----------------------------------------------------------------------------------------------------------------------------------------------------------
    users_install_requires           BOOLEAN            YES       true          Installation des dependances du rôle sur les remote host.
    users_system                     HASHES             NO        []            Hashes de données pour la gestion des users system.
      group                          DICTIONNARY        NO        []            Groupes system à créer.
      user                           DICTIONNARY        NO        []            Utilisateurs system à créer.
    users_mysql                      HASHES             NO        []            Hashes de données pour la gestion des users mysql.
      database                       DICTIONNARY        NO        []            Base de données mysql à créer.
      user                           DICTIONNARY        NO        []            Utilisateur mysql à créer.
    users_postgresql                 HASHES             NO        []            Hashes de données pour la gestion des users postgresql.
      database                       DICTIONNARY        NO        []            Base de données postgressql à créer.
      user                           DICTIONNARY        NO        []            Utilisateur postgresql à créer.
      priv                           DICTIONNARY        NO        []            Gestion des privilèges étendues associées aux objets postgresql.
    users_mongodb                    HASHES             NO        []            Hashes de données pour la gestion des users mongodb.
      user                           DICTIONNARY        NO        []            Utilisateur mongodb à créer.

 Tags
---------
    TAG NAME
    ----------------------------------------------------------------------------------------------------------------------------------------------------------
    users
    users_install
    users_system
    users_mysql
    users_postgresql
    users_mongodb

 Extra-variable
---------
    VARIABLES                       TYPES/VALEURS      REQUIS    DEFAULT       DESCRIPTION
    ----------------------------------------------------------------------------------------------------------------------------------------------------------
    no_log                          BOOLEAN            NO        true          Disable sensible log

 Dictionnaires
---------


    DICTIONNAIRES                   TYPES/VALEURS      REQUIS    DEFAULT       DESCRIPTION
    ----------------------------------------------------------------------------------------------------------------------------------------------------------
    `users_system.group`              DICTIONNARY        NO        []            Dictionnaire de données groupes system.
       name                           STRING             YES       undef         Nom du group à créer.
       system                         STRING             NO        no            Groupe system?
       gid                            INTEGER            NO        undef         Forcer le gid à utiliser pour le group
       state                          STRING             NO        present       Statut du goupe. present ou absent.

    `users_system.user`               DICTIONNARY        NO        []            Dictionnaire de données utilsateurs system.
       name                           STRING             YES       undef         Nom du user à créer.
       group                          STRING             NO        undef         Groupe primaire du user. Si pas defini prend `name`.
       groups                         LIST               NO        undef         Groupe secondaire du user. Cf valeur de la variable `append`
       append                         BOOLEAN            NO        undef         Créer les groupes si false, ajouter en groupe secondaire si true.
       uid                            INTEGER            NO        undef         Forcer l'uid à utiliser pour le user.
       non_unique                     BOOLEAN            NO        no            Force un uid non unique. (Alias d'un compte)
       comment                        STRING             NO        undef         Gecos du compte.
       password                       SHA512_CRYPT       NO        undef         Mot de passe du user au format SHA512. Cf => http://goo.gl/xCvxNm
       home                           PATH               NO        undef         home du user à créer.
       createhome                     BOOLEAN            NO        yes           Sauf valeur à false, la home du user sera crée.
       shell                          PATH               NO        /bin/bash     Shell du user à créer.
       system                         BOOLEAN            NO        no            Compte system ?
       generate_ssh_key               BOOLEAN            NO        no            Génerer une clef SSH pour le user ?
       ssh_key_passphrase             STRING             NO        undef         Passphrase de la clef SSH à génerer.
       ssh_key_file                   PATH               NO        .ssh/id_rsa   Le nom du fichier où sera généré la clef SSH.
       ssh_key_type                   STRING             NO        rsa           Type d'algorithme à utiliser pour générer la clef SSH.
       ssh_key_bits                   INTEGER            NO        2048          Nombre de bits à utiliser pour générer la clef SSH.
       ssh_key_comment                STRING             NO        ansible-*     Gecos de la clef SSH à générer.
       authorized_keys                LIST               NO        undef         Liste des clef public SSH à autoriser.
       expires                        EPOCH              NO        undef         Date d'expiration du compte.
       move_home                      BOOLEAN            NO        no            Deplacer la home avec tout son contenu du user vers la nouvelle home.
       remove                         BOOLEAN            NO        no            Force la suppression du user avec toutes les données.
       state                          STRING             NO        present       Statut du user. present ou absent.
       sudo                           HASH               NO        present       HASH de définition des variables relatives au sudo.
         content                      RAW                NO        undef         Utiliser un contenu en mode raw plutot qu'un template jinja.
         template                     PATH               NO        undef         Utiliser un template personalisé.
         append                       RAW                NO        undef         Ajouter du contenu raw directement à la fin du template jinja.
         commands                     LIST               NO        undef         Liste des commandes que le user peut exectuer via sudo.
         cmnd_alias                   LIST               NO        undef         Grouper plusieurs commandes dans un seul nom.
         defaults                     LIST               NO        undef         Surcharge des paramètres par défaut du run-time.
         groups                       STRING             NO        undef         Lancer en tant que (group). Séparer par des virgules si plusieurs groups.
         host_alias                   LIST               NO        undef         Associer des hosts à un alias sur lesquels autoriser les commandes
         nopasswd                     BOOLEAN            NO        undef         NO PASSWORD ?
         requiretty                   BOOLEAN            NO        undef         TTY ? (*Deprecated*. Cf paramètre **defaults**)
         runas_alias                  LIST               NO        undef         Lancer les commandes en tant que tel user(s) ou group(s)
         users                        STRING             NO        undef         Lancer en tant que (user). Separer par des virgules si plusieurs users.
         user_alias                   LIST               NO        undef         Créer un groupe d'utilisateur.


    `users_mysql.database`            DICTIONNARY        NO        []            Dictionnaire de données des bases données.
       name                           STRING             YES       undef         Nom de la database à créer.
       collation                      STRING             NO        undef         Collation mode.
       encoding                       STRING             NO        undef         Encoding mode.
       state                          STRING             NO        present       Statut de la database. VEROUILLÉ à PRESENT.
       login_port                     INTEGER            NO        3306          Port d'écoute du serveur mysql.
       login_host                     IPV4|HOSTNAME      NO        undef         Serveur mysql sur lequel se connecter.
       login_user                     STRING             NO        undef         Username à utiliser pour se loguer au seveur mysql.
       login_password                 STRING             NO        undef         Password à utiliser pour se loguer au seveur mysql.
       login_unix_socket              PATH               NO        undef         Path de la socket unix pour les connexions locales.

    `users_mysql.user`                DICTIONNARY        NO        []            Dictionnaire de données des users mysql.
       name                           STRING             YES       undef         Nom de l'utilisateur à créer.
       host                           IPV4|HOSTNAME      NO        localhost     Host depuis lequel le user peut se connecter.
       encrypted                      BOOLEAN            NO        no            Format mot de passe HASHED (yes) | UNHASHED (no). Cf section `Tips`
       password                       STRING             YES       undef         Password du user mysql. Si encrypted => yes, alors Cf section `Tips`
       priv                           LIST               YES       undef         Liste des privilèges associé au compte au format `db.table:priv1,priv2.`
       append_privs                   BOOLEAN            NO        yes           Ajouter les privileges au user s'il existe dejà et non l'écraser.
       state                          STRING             NO        present       Statut du user. present ou absent.
       login_port                     INTEGER            NO        3306          Port d'écoute du serveur mysql.
       login_host                     IPV4|HOSTNAME      NO        undef         Serveur mysql sur lequel se connecter.
       login_user                     STRING             NO        undef         Username à utiliser pour se loguer au seveur mysql.
       login_password                 STRING             NO        undef         Password à utiliser pour se loguer au seveur mysql.
       login_unix_socket              PATH               NO        undef         Path de la socket unix pour les connexions locales.

    `users_postgresql.database`       DICTIONNARY        NO        []            Dictionnaire de données des bases de données postgresql.
       name                           STRING             YES       undef         Nom de la base de données à créer.
       lc_collate                     STRING             NO        undef         Collation mode.
       lc_ctype                       STRING             NO        undef         Character classification.
       encoding                       STRING             NO        undef         Encoding mode.
       state                          STRING             NO        present       Status de la database. VEROUILLÉ à PRESENT.
       login_port                     INTEGER            NO        5432          Port d'écoute du serveur postgresql.
       login_host                     IPV4|HOSTNAME      NO        undef         Serveur postgresql sur lequel se connecter.
       login_user                     STRING             NO        undef         Username à utiliser pour se loguer au seveur postgresql.
       login_password                 STRING             NO        undef         Password à utiliser pour se loguer au seveur postgresql.
       login_unix_socket              PATH               NO        undef         Path de la socket unix pour les connexions locales.

    `users_postgresql.user`           DICTIONNARY        NO        []            Dictionnaire de données des users postgresql.
       name                           STRING             YES       undef         Nom de l'utilisateur à créer.
       encrypted                      BOOLEAN            NO        no            Format mot de passe HASHED (yes) | UNHASHED (no).
       password                       STRING             YES       undef         Password du user. encrypted: yes ~> echo "md5`echo -n "verysecretpasswordJOE" | md5`"
       database                       STRING             NO        undef         Database sur laquelle les GRANTS sont à appliquer.
       priv                           LIST               NO        undef         Liste des privilèges associés au compte au format `table:priv1,priv2.`
       role_attr_flags                LIST               NO        undef         Liste des attributs à associer au rôle au format `CREATEDB,CREATEROLE,SUPERUSER`.
       expires                        DATE               NO        undef         Date d'expiration du compte.
       state                          STRING             NO        present       Statut du user. present ou absent.
       login_port                     INTEGER            NO        5432          Port d'écoute du serveur postgresql.
       login_host                     IPV4|HOSTNAME      NO        undef         Serveur postgresql sur lequel se connecter.
       login_user                     STRING             NO        undef         Username à utiliser pour se loguer au seveur postgresql.
       login_password                 STRING             NO        undef         Password à utiliser pour se loguer au seveur postgresql.
       login_unix_socket              PATH               NO        undef         Path de la socket unix pour les connexions locales.

    `users_postgresql.priv`           DICTIONNARY        NO        []            Dictionnaire de données des privileges étendues postgresql.
       name                           STRING             YES       undef         Nom de la database sur laquelle se connecter.
       schema                         STRING             NO        undef         Schema contenant la database. Cf objs.
       type                           STRING             NO        undef         Type d'objets. `table|sequence|function|database|schema|language|tablespace|group`
       objs                           LIST               NO        undef         Liste des ojbets pour lesquels appliquer les permissions.
       priv                           LIST               NO        undef         Liste des privilèges associés aux rôles(user/group) au format `table:priv1,priv2.`
       roles                          LIST               YES       undef         Liste des rôles(user/group) pour lesquels appliquer les permissions.
       grant_option                   BOOLEAN            NO        undef         Avec option GRANT ?
       state                          STRING             NO        present       Statut du user. present ou absent.
       login_port                     INTEGER            NO        5432          Port d'écoute du serveur postgresql.
       login_host                     IPV4|HOSTNAME      NO        undef         Serveur postgresql sur lequel se connecter.
       login_user                     STRING             NO        undef         Username à utiliser pour se loguer au seveur postgresql.
       login_password                 STRING             NO        undef         Password à utiliser pour se loguer au seveur postgresql.
       login_unix_socket              PATH               NO        undef         Path de la socket unix pour les connexions locales.

    `users_mongodb.user`              DICTIONNARY        NO        []            Dictionnaire de données des users mongodb.
       name                           STRING             YES       undef         Nom de l'utilisateur à créer.
       password                       STRING             YES       undef         Password du user.
       update_password                STRING             NO        always        `always` update le password si different de l'ancien. `on_create` uniquement à la creation du user.
       database                       STRING             YES       undef         Database sur laquelle les GRANTS sont à appliquer. Créee si inexistante.
       replica_set                    STRING             NO        undef         Replica set sur lequel se connecter. Pour les write par defaut sur le PRIMARY.
       roles                          LIST               NO        readWrite     Liste des rôles du user au format: `read|readWrite|dbAdmin|userAdmin|clusterAdmin|readAnyDatabase|readWriteAnyDatabase|userAdminAnyDatabase|dbAdminAnyDatabase`.
       ssl                            STRING             NO        absent        Connexion via SSL?
       state                          STRING             NO        present       Statut du user. present ou absent.
       login_port                     INTEGER            NO        27017         Port d'écoute du serveur mongodb.
       login_host                     IPV4|HOSTNAME      NO        undef         Serveur mongondb sur lequel se connecter.
       login_user                     STRING             NO        undef         Username à utiliser pour se loguer au seveur mongodb.
       login_password                 STRING             NO        undef         Password à utiliser pour se loguer au seveur mongodb.
       login_database                 STRING             NO        undef         Base de données ou sont stockés les données d'authentification
       login_unix_socket              PATH               NO        undef         Path de la socket unix pour les connexions locales.   

Dependances
------------
- [x]  sudo
- [x]  python-mysqldb
- [x]  python-software-properties
- [x]  python-psycopg2
- [x]  python-pymongo

Les dépendances sont automatiquement installées par le rôle si `users_install_requires => true`.

QuickStart
----------

  - **Installation et configuration**

    * Créer/Modifier le fichier `requirements.yml`.  ⚠️ Ne pas supprimer les lignes dejà existantes du fichier.

        ```yaml
        - src: git+ssh://git@git.alterway.fr/ansibleroles/awh-users.git
          version: origin/master
          name: users
        ```

    * Installer le role:
      ```
      ansible-galaxy install -r requirements.yml --force
      ```


  - **Exemple complet de Playbook**

    ⚠️ Sur le serveur **electron** de deploiement il est interdit de créer des playbooks avec des variables. Veuillez vous réferer à cet effet à la documentation de  [l'orchestrateur](https://git.alterway.fr/Orchestrator/orchestrator/blob/master/README.md)

   Fichier `playbook-users.yml` à copier depuis le dossier `examples`. Les variables, dict, hashes, list, array sont à modifier/adapter ou à ajouter selon besoin. Cf section [Variables](#variables).

```yaml
    - hosts: users_hosts
      no_log: True  ## On log pas car des info sensibles transitent.
      user: ansible
      gather_facts: yes
      sudo: True

      roles:
       - users
      vars:
        users_system:
          group:
            - name: awh
              state: present
              system: no
              gid: 1005
            - name: deploy
              state: present
            - name: devops
              state: present
            - name: combo
              state: present
            - name: fatality
            - name: raptor
            - name: cortex
          user:
            - name: helldorado
              group: helldorado
              groups:
                - ‘awh’
                - ‘deploy’
                - ‘cortex’
              append: yes
              uid: 1300
              comment: 'Compte Admin'
              password: '$6$rounds=656000$JF8tFeeiJD50ELTt$Y1xrYwo8/XlfEu1gzwtvcLubehyAEtv5aLOwPff9TUABwkL.0UbPJLKebyBYy3ScuB0f/U6Gd/b.tgSL8Fr4Y0'
              home: '/home/hell'
              createhome: yes
              generate_ssh_key: yes
              ssh_key_passphrase: 'Si Java avait un vrai garbage collector (collecteur de dechets, ndt), la plupart des programmes se supprimeraient eux-memes lors de l execution'
              authorized_keys:
                - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCw/7e44AMATsCIqCdQaehYc84L+DYOZMA29pJ9JQLPGdMrfr0rQKAGsWp7uLSKIHlZYQx40XAjo5oW2ge6pvizaOaOK3sn4ddfI0n1kTyfV2lNYrbxHjtcUL0QOQxxL/7HL8m5JyLCekDg3XiiwoBTyNC9gSyMbPKoFy+nlJpjxpju5AOBxM5xOiEzfzJsULHyuFP+ZxQ9GwvLOuXGg9BotYA/jPJFTGG95t4HK+SvJ1CMHpamFJr4OXVxtSTRbMhvlP3Zd+3pwGr8pZc/JhYP5mrBxQ/QwHc/pzeYJv62ocuOXv70+hDn453Bml4FcKz2yrZBAYWkydkIU511k/3N helldorado@spynol.local
                    '
                - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPE3Jk66nKUMp0m0mgEpougo/qCUrW+ZDQHb8w+2QQiw/t5xJk0uhnkT1TPcNk+5Mdmjx264gHh/nAk0XgG1jhsSKlPzkgAcyBNw89tLKESkMvh2DlYzmvqG5b/YiQ8BPPBB+2ghxpoUixDPaJQS7Mr/BgkAWXN28oLNsFkhY1gCdWUHDH1XhXQsRYsZtw0TbAz/j+oOu233Hq/J9UB9w2UuGLr9z1cQY516vBSblrpfNjDWfmwLHENoeqZTsqFiivgYjMVc2RjLwgLM1ORJopfay0Gj7q9xz9hidUwqyyL7OkIK/FYA32JmT4REYr7d0uEwTm0zAfWG+ab4rKWNnB helldorado@spynol.local
                    '
              sudo:
                nopasswd: yes
                requiretty: yes
                user: 'helldorado, test'
                defaults:
                  - secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                  - syslog=auth
                commands:
                   - '/etc/init.d/mysql restart'
                   - '/etc/init.d/postgresql restart'
            - name: test
              group: test
              append: yes
              uid: 1301
              comment: 'Compte Test'
              password: '$6$rounds=656000$JF8tFeeiJD50ELTt$Y1xrYwo8/XlfEu1gzwtvcLubehyAEtv5aLOwPff9TUABwkL.0UbPJLKebyBYy3ScuB0f/U6Gd/b.tgSL8Fr4Y0'
              home: '/home/test'
              createhome: yes
              sudo:
                nopasswd: yes
                requiretty: no
                user: 'helldorado, test'
                groups: 'helldorado'
                defaults:
                  - 'mail_badpass'
                  - 'env_reset'
                  - '!requiretty'
                commands:
                   - '/bin/ls'
                   - '/usr/bin/su [!-]*'
                   - '!/usr/bin/su *root*'
            - name: combo
              group: combo
              append: yes
              password: '$6$rounds=656000$JF8tFeeiJD50ELTt$Y1xrYwo8/XlfEu1gzwtvcLubehyAEtv5aLOwPff9TUABwkL.0UbPJLKebyBYy3ScuB0f/U6Gd/b.tgSL8Fr4Y0'
              createhome: yes
              sudo:
                nopasswd: yes
                defaults:
                  - 'mail_badpass'
                runas_alias:
                  - 'OP= root, operator'
                  - 'DB= oracle, sybase'
                cmnd_alias:
                  - |-
                    DUMPS = /usr/bin/mt, /usr/sbin/dump, /usr/sbin/rdump,\
                                           /usr/sbin/restore, /usr/sbin/rrestore,\
                                           sha224:0GomF8mNN3wlDt1HD9XldjJ3SNgpFdbjO1+NsQ== \
                                           /home/operator/bin/start_backup
                  - |-
                    SHELLS = /usr/bin/sh, /usr/bin/csh, /usr/bin/ksh,\
                                            /usr/local/bin/tcsh, /usr/bin/rsh,\
                                            /usr/local/bin/zsh
                  - KILL = /usr/bin/kill, /sbin/halt
                commands:
                   - DUMPS
                   - KILL
                   - SHELLS
                append: |
                        %combo ALL=(ALL:ALL) NOPASSWD: DUMPS
            - name: spinal
              group: combo
              append: yes
              password: '$6$rounds=656000$JF8tFeeiJD50ELTt$Y1xrYwo8/XlfEu1gzwtvcLubehyAEtv5aLOwPff9TUABwkL.0UbPJLKebyBYy3ScuB0f/U6Gd/b.tgSL8Fr4Y0'
              createhome: yes
              sudo:
                content: |
                         # Ansible managed

                         Defaults:combo mail_badpass
                         Runas_Alias    SYSADMIN= root, operator
                         Runas_Alias    DBAMAIN= oracle, sybase
                         Cmnd_Alias     DBDUMPS = /usr/bin/mt, /usr/sbin/dump, /usr/sbin/rdump,\
                                                /usr/sbin/restore, /usr/sbin/rrestore,\
                                                /home/operator/bin/start_backup
                         Cmnd_Alias     SERVICES = /etc/init.d/apache2 re*, /etc/init.d/nginx re*

                         combo ALL=(ALL:ALL) NOPASSWD: DBDUMPS, SERVICES
                state: present
            - name: ikora
              group: ikora
              append: yes
              sudo:
                template: test/datas/sudoers.d/ikora.j2

        users_mysql:
          database:
            - name: spinal
              collation: utf8_general_ci
              encoding : utf8
            - name: fulgor
            - name: smoke
            - name: kitana
              encoding : utf8
            - name: cyrax
              collation: latin1_swedish_ci
          user:
            - name: sabrewulf
              password: 'C8XR6FgsK9nME'
              host:
                - 127.0.0.1
                - ‘10.0.1.%’
                - localhost
              priv:
                - 'spinal.*:SELECT,INSERT'
                - 'fulgor.user:ALL'
              append_privs: yes
            - name: raiden
              password: 'AydPLY1GOSPAA'
              host: [‘localhost’, ‘127.0.0.1’, ‘10.0.16.%’]
              priv:
                - 'kitana.*:ALL'
                - 'cyrax.*:ALL'
              append_privs: yes
            - name: beastie
              password: '*02327FF7844C866C43469F64FE2CAC022C8FBD22' ## Genéré via python -c ‘from hashlib import sha1; import getpass; print “*” + sha1(sha1(getpass.getpass(“New MySQL Password:”)).digest()).hexdigest()’
	            encrypted: yes
              priv:
                - 'foobar.*:ALL'
              append_privs: yes

        users_postgresql:
          database:
            - name: db_glacius
              encoding: UTF-8
              lc_collate: en_US.UTF-8
              lc_ctype: en_US.UTF-8
            - name: db_jago
            - name: db_orchid
            - name: db_spinal
          user:
            - name: glacius
              password: 'C8XR6FgsK9nME'
              database: db_glacius
              priv:
                - CONNECT
                - products:SELECT
                - users:ALL
                - name: raiden
              encrypted: true
              password: 'md5d011966da94d776cf59bf6dbde240e5d'
              expires: infinity
              role_attr_flags:
                - CREATEDB
                - NOSUPERUSER
                - CREATEROLE
            - name: sabrewulf
              encrypted: true
              password: 'md5d011966da94d776cf59bf6dbde240e5d'
              database: db_glacius
              expires: "August 25 12:00:00 2016 +1"
              priv:
                - 'ALL'
                - 'creditcard:SELECT'
                - name: spinal
              encrypted: true
              password: 'md5d011966da94d776cf59bf6dbde240e5d'
              database: db_spinal
              expires: infinity
              priv:
                - 'ALL'
            - name: jago
              encrypted: true
              password: 'md5d011966da94d776cf59bf6dbde240e5d'
              expires: infinity
          priv:
              # On database "db_orchid":
              # GRANT SELECT, INSERT, UPDATE ON TABLE public.books, public.authors public.users
              # TO glacius,admin,spinal WITH GRANT OPTION
            - name: db_orchid
              priv:
                - 'SELECT,INSERT,UPDATE'
              type: table
              objs: 'books,authors,users'
              schema: public
              roles: "glacius,raiden,spinal"
              grant_option: yes

            # GRANT ALL PRIVILEGES ON DATABASE db_jago TO jago
            # Note that here "db=postgres" specifies the database to connect to, not the
            # database to grant privileges on (which is specified via the "objs" param)
            - name: postgres
              priv:
                - 'ALL'
              type: database
              objs: db_jago
              roles: jago
              grant_option: yes

            # GRANT admin, combo TO spinal, glacius WITH ADMIN OPTION
            # Note that group role memberships apply cluster-wide and therefore are not
            # restricted to database "db_glacius" here.
            - name: db_glacius
              state           : present
              type            : group
              objs            : "raiden,sabrewulf"
              roles           : "spinal,glacius"
              admin_option    : yes

        users_mongodb:
          user:
            - name: sabrewulf
              database: combo
              password: 'C8XR6FgsK9nME'
              roles:
                - readWrite
                - readAnyDatabase
            - name: raiden
              database: spinal
              password: 'C8XR6FgsK9nME'
              roles:
                - readWrite
                - dbAdmin
                - readAnyDatabase
```

  - ***RUN !***

    ```
    ansible-playbook playbooks/users.yml
    ```   
  - **Tips**
	* Génération d'un mot de passe MySQL
	```
	python -c 'from hashlib import sha1; import getpass; print "*" + sha1(sha1(getpass.getpass("New MySQL Password:")).digest()).hexdigest().upper()'
	```
  	* Pour gagner du temps, utilisez  ```--tags``` et ```--skip-tags```

			TAG                        DESCRIPTION                              EXEMPLES
			--------------------------------------------------------------------------------------------------------------------------------------------------
			users                    Tag general. s'applique à tout.           'ansible-playbook playbook-users.yml --tags users'
			users_install            Installation des dependances.             'ansible-playbook playbook-users.yml --tags users_install'
            users_system             Management Users/Groups System.           'ansible-playbook playbook-users.yml --tags users_system'
            users_mysql              Management Users/Databases MYSQL.         'ansible-playbook playbook-users.yml --tags users_mysql'
            users_postgresql         Management Users/Databases POSTGRESQL.    'ansible-playbook playbook-users.yml --tags users_postgresql'
            users_mongodb            Management Users/Databases MONGODB.       'ansible-playbook playbook-users.yml --tags users_mongodb'


>    Quand c'est possible/necessaire, utiliser `--start-at-task` afin de commencer sur une tache spécifque.

   ```
   ansible-playbook playbooks/users.yml --start-at-task "User create/modify/delete"
   ```
   * **Liste des Tasks et Tags**   

	   ```bash
	TASK	                                                TAGS: []
	-------------------------------------------------------------------------------------------------------
    Install dependencies	                                [users, users_install]
    Manage groups	                                        [users, users_system, users_system_group]
    User create/modify/delete	                            [users, users_system, users_system_user]
    SSH Authorized Keys	                                    [users, users_authorized_key, users_system]
    Ensure sudoers.d is included in config	                [users, users_sudo, users_system]
    add custom sudoers	                                    [users, users_sudo, users_system]
    Create database	                                        [users, users_mysql]
    Manage MySQL users.	                                    [users, users_mysql]
    Create Databases	                                    [users, users_postgresql]
    Manage Postgresql Users	                                [users, users_postgresql]
    Grant/Revoke privileges on database objects             [users, users_postgresql]
    Manage MongoDB Users	                                [users, users_mongodb]
       ```

Exemples
--------

   Des exemples de dictionnaire de données sont disponibles dans le dossier [examples](http://gitlab.nexen.net/ansibleroles/awh-users/blob/master/examples/). Vous y trouverez pour chaque dictionnaire de données un exemple d'utilisation.


## Developpement

### Bugs et ajout de fonctionnalités

Si vous constatez un bug, merci de verifier la listes des [tickets ouverts](http://gitlab.nexen.net/ansibleroles/awh-users/issues)

Si vous avez un problème avec l'utilisation ou des idées qui ne sont pas reportés ici, je reste dispo juste à coté, ou via IRC ou encore par mail [abdoul.bah@alterway.fr](abdoul.bah@alterway.fr)

### Contribuer à l'évolution de ce role

Les pull/merge request sont les bienvenues.

Assurez-vous d'avoir testé vos modification via les outils de test **Vagrantfile** et **Rspec** disponible dans le repertoire `test`.

```bash
.
├── Rakefile
├── Vagrantfile
├── hosts
├── inventory
├── playbook.yml
├── spec
│   ├── spec_helper.rb
│   └── users
│       └── users_spec.rb
└── users -> ../../awh-users
```

Fichier `[test/Vagrantfile](http://gitlab.nexen.net/ansibleroles/awh-users/blob/master/tests/Vagrantfile)`

```ruby
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "helldorado-debian-7-7-amd64"

  config.vm.box_url = "http://awh.helldorado.info/helldorado-debian-7-7-amd64.box"

  config.vm.define :users do |users|
    config.vm.hostname = "users"
    users.vm.network "private_network", ip: "172.20.20.30"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    #ansible.inventory_path = "inventory"
    ansible.limit = 'all'
    ansible.sudo = true
    ansible.host_key_checking = false
    ansible.raw_arguments = ENV['ANSIBLE_ARGS']
  end
end
```
- **Etape 1 :**
	* Se placer dans le repertoire test

		```bash
		cd awh-users/tests
		```

	* Lancer l'installation de la VM (Cette étape peut durer pour le premier lancement. Soyez patient.)

		```bash
		vagrant up
		```
	* Connectez-vous au serveur via la commande ```vagrant ssh``` et installez les softs permettant de tester le role.
	  - MYSQL (Créer le fichier .my.cnf dans /root)
	  - POSTGRESQL (Créer également les tables pour le schema public)
	  - MONGODB

  * Provisionner les VM via le playbook ansible

     ```bash
     vagrant provision
     ```

- **Etape 2 :**

    - Lancement des tests **Rspec** via **ServerSpec**

		```bash
		rake spec:users
		```

- **Etape 3 :**
  - Se connecter à la VM pour verifier manuellement la configuration des users et databases. ```vagrant ssh```


> Vous pouvez trouver de la documation sur l'utilisation de **Vagrant** et **ServerSpec** via les liens suivants.

[Vagrant Ansible provisioner](https://docs.vagrantup.com/v2/provisioning/ansible.html)

[ServerSpec Resource Types](http://serverspec.org/resource_types.html)


Exemple de sortie (Pour les tests effectués, cf fichier `users_spec.rb`)

```yaml
User resource type
  User "helldorado"
    should exist
    should belong to group "helldorado"
    should have home directory "/home/hell"
    should have login shell "/bin/bash"
  Group "helldorado"
    should exist

User and database on mysql exist
  'sabrewulf' and 'raiden' mysql user is created for localhost
    Command "sudo echo "SELECT User, Host FROM mysql.user" | mysql"
      stdout
        should match /sabrewulf\tlocalhost/
      stdout
        should match /raiden\tlocalhost/
  'spinal' database exists
    Command "sudo echo "SHOW DATABASES LIKE 'spinal'" | mysql"
      stdout
        should match /spinal/

User and database on postgresql exist
  'glacius' and 'jago' postgresql user is created
    Command "sudo -u postgres -s psql postgres -tAc "\du""
      stdout
        should match /glacius/
      stdout
        should match /jago/
  'db_glacius' and 'db_orchid' postgresql database exist
    Command "sudo -u postgres -s psql postgres -tAc "\l""
      stdout
        should match /db_glacius/
      stdout
        should match /db_orchid/

Finished in 0.41298 seconds (files took 4.95 seconds to load)
12 examples, 0 failures
```


### Documention utile dans la rédaction de roles et playbooks

* Ansible playbook best pratices [style guide](http://docs.ansible.com/playbooks_best_practices.html).
* A propos des commits [propres et comprehensifs ](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).


## Credits

* **Abdoul Bah**
* [Contributeurs](http://gitlab.nexen.net/ansibleroles/awh-users/graphs/master)

## Licence

GPLv2

## References
- [Ansible](http://www.ansibleworks.com)
- [Ansible Modules](http://docs.ansible.com/ansible/modules_by_category.html)
- [Ansible Playbook](http://docs.ansible.com/playbooks.html)
- [Ansible Role](http://docs.ansible.com/playbooks_roles.html)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [YAML Gotchas](http://www.yaml.org/spec/1.2/spec.html)
- [Contributing to open-source](https://guides.github.com/activities/contributing-to-open-source)
- [About commit](https://help.github.com/categories/commits/)
