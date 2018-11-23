require 'serverspec'
set :backend, :exec

def isApache24?()
  if (os[:family] == 'debian' && ( os[:release] =~ /8\..*/ || os[:release] =~ /9\..*/ ) ) then
    return true
  elsif (os[:family] == 'ubuntu') then
    return true
  elsif (os[:family] == 'redhat' && os[:release] =~ /7\..*/) then
    return true
  end
  return false
end

describe file('/var/www/directories') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/directoriesempty1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/directoriesempty1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/directoriesempty1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<VirtualHost *:80>',
    'ServerName directoriesempty1',
    'DocumentRoot  "/var/www/directories"',
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "directoriesempty1" env=DEBUG'
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'ServerAdmin ',
    '<Directory',
    '<Location',
    '<Files',
    '<Proxy',
    'GeoIPEnable ',
    'Options ',
    'IndexOptions ',
    'IndexOrderDefault ',
    'IndexStyleSheet ',
    'AllowOverride ',
    '<RequireAll>',
    'Require ',
    '</RequireAll>',
    'Order ',
    'Deny ',
    'Allow ',
    'Satisfy ',
    '<FilesMatch',
    'SetHandler ',
    '</FilesMatch>',
    'PassengerEnabled ',
    'php_flag ',
    'php_value ',
    'php_admin_flag ',
    'php_admin_value ',
    'DirectoryIndex ',
    'ErrorDocument ',
    'AuthType ',
    'AuthName ',
    'AuthDigestAlgorithm ',
    'AuthDigestDomain ',
    'AuthDigestNonceLifetime ',
    'AuthDigestProvider ',
    'AuthDigestQop ',
    'AuthDigestShmemSize ',
    'AuthBasicAuthoritative ',
    'AuthBasicFake ',
    'AuthBasicProvider ',
    'AuthUserFile ',
    'AuthGroupFile ',
    'FallbackResource ',
    'ExpiresActive ',
    'ExpiresDefault ',
    'ExpiresByType ',
    'ExtFilterOptions ',
    'ForceType ',
    'SSLOptions ',
    'suPHP_UserGroup ',
    'FcgidWrapper ',
    'RewriteEngine On',
    'RewriteBase ',
    'RewriteCond ',
    'RewriteRule ',
    'SetEnv ',
    'SetOutputFilter ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-enabled/directoriesempty2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/directoriesempty2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/directoriesempty2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<VirtualHost *:80>',
    'ServerName directoriesempty2',
    'DocumentRoot  "/var/www/directories"',
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "directoriesempty2" env=DEBUG'
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'ServerAdmin ',
    '<Directory ',
    '<Location ',
    '<Files ',
    '<Proxy ',
    'GeoIPEnable ',
    'Options ',
    'IndexOptions ',
    'IndexOrderDefault ',
    'IndexStyleSheet ',
    'AllowOverride ',
    '<RequireAll>',
    'Require ',
    '</RequireAll>',
    'Order ',
    'Deny ',
    'Allow ',
    'Satisfy ',
    '<FilesMatch',
    'SetHandler ',
    '</FilesMatch>',
    'PassengerEnabled ',
    'php_flag ',
    'php_value ',
    'php_admin_flag ',
    'php_admin_value ',
    'DirectoryIndex ',
    'ErrorDocument ',
    'AuthType ',
    'AuthName ',
    'AuthDigestAlgorithm ',
    'AuthDigestDomain ',
    'AuthDigestNonceLifetime ',
    'AuthDigestProvider ',
    'AuthDigestQop ',
    'AuthDigestShmemSize ',
    'AuthBasicAuthoritative ',
    'AuthBasicFake ',
    'AuthBasicProvider ',
    'AuthUserFile ',
    'AuthGroupFile ',
    'FallbackResource ',
    'ExpiresActive ',
    'ExpiresDefault ',
    'ExpiresByType ',
    'ExtFilterOptions ',
    'ForceType ',
    'SSLOptions ',
    'suPHP_UserGroup ',
    'FcgidWrapper ',
    'RewriteEngine On',
    'RewriteBase ',
    'RewriteCond ',
    'RewriteRule ',
    'SetEnv ',
    'SetOutputFilter ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/directoriesproviders.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/directoriesproviders.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/directoriesproviders.conf'), :if => isApache24?() do
  [
    'Require all granted',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'Allow ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/directoriesproviders.conf'), :if => ! isApache24?() do
  [
    'Order allow,deny',
    'Allow from all',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'Require ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/directoriesproviders.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<VirtualHost *:80>',
    'ServerName directoriesproviders',
    'DocumentRoot  "/var/www/directories"',
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "directoriesproviders" env=DEBUG',
    '<Directory "/toto">',
    '<Location "/tata">',
    '<Location "/secure">',
    '<Files "/titi">',
    '<Proxy "/tutu">',
    '<DirectoryMatch "/tototo">',
    '<LocationMatch "/tatata">',
    '<FilesMatch "/tititi">',
    '<ProxyMatch "/tututu">',
    'AllowOverride None',
    'AuthType shibboleth',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'ServerAdmin ',
    'GeoIPEnable ',
    'Options ',
    'IndexOptions ',
    'IndexOrderDefault ',
    'IndexStyleSheet ',
    '<RequireAll>',
    '</RequireAll>',
    'Deny ',
    'Satisfy ',
    'SetHandler ',
    'SetHandler ',
    'PassengerEnabled ',
    'php_flag ',
    'php_value ',
    'php_admin_flag ',
    'php_admin_value ',
    'DirectoryIndex ',
    'ErrorDocument ',
    'AuthName ',
    'AuthDigestAlgorithm ',
    'AuthDigestDomain ',
    'AuthDigestNonceLifetime ',
    'AuthDigestProvider ',
    'AuthDigestQop ',
    'AuthDigestShmemSize ',
    'AuthBasicAuthoritative ',
    'AuthBasicFake ',
    'AuthBasicProvider ',
    'AuthUserFile ',
    'AuthGroupFile ',
    'FallbackResource ',
    'ExpiresActive ',
    'ExpiresDefault ',
    'ExpiresByType ',
    'ExtFilterOptions ',
    'ForceType ',
    'SSLOptions ',
    'suPHP_UserGroup ',
    'FcgidWrapper ',
    '# Rewrite rules',
    'RewriteEngine On',
    'RewriteBase ',
    'RewriteCond ',
    'RewriteRule ',
    'SetEnv ',
    'SetOutputFilter',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/directoriesdirectory.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/directoriesdirectory.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/directoriesdirectory.conf'), :if => isApache24?() do
  [
    '<RequireAll>',
        'Require method GET POST OPTIONS',
        'Require ldap-group cn=Administrators,o=awh',
        'Require ldap-attribute o="st"',
    '</RequireAll>',
    '<RequireAny>',
        'Require group admin',
        'Require group wheel',
        'Require group god',
    '</RequireAny>',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'Order ',
    'Deny ',
    'Allow ',
    'Satisfy ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/directoriesdirectory.conf'), :if => ! isApache24?() do
  [
    'Order deny,allow',
    'Allow from all',
    "Order allow,deny",
    'Deny from 8.8.8.8',
    'Deny from all',
    'Allow from 127.0.0.1',
    'Allow from 192.168.0.0/16',
    'Satisfy Any',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/directoriesdirectory.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<VirtualHost *:80>',
    'ServerName directoriesdirectory',
    'DocumentRoot  "/var/www/directories"',
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "directoriesdirectory" env=DEBUG',
    '<Directory "/tmp">',
    'Header set my-custom-header "%D %t"',
    'Header merge Cache-Control no-cache env=NO_CACHE',
    'GeoIPEnable on',
    'Options -Indexes -FollowSymlinks +MultiViews',
    'IndexOptions type=text/plain -IgnoreCase +IgnoreClient',
    'IndexOrderDefault Ascending Name',
    'IndexStyleSheet \'/opt/style.css\'',
    'AllowOverride Limit FileInfo',
    'Require valid-user',
    '<FilesMatch "(.cgi|.gi)$">',
    'SetHandler cgi-script',
    '<FilesMatch "(.test|.tst)$">',
    'SetHandler test',
    '</FilesMatch>',
    'SetHandler kiwi',
    'PassengerEnabled on',
    'php_flag short_open_tag Off',
    'php_flag precision 13',
    'php_value asp_tags "1"',
    'php_value allow_call_time_pass_reference "0"',
    'php_admin_flag zend.multibyte 1',
    'php_admin_value html_errors "1"',
    'DirectoryIndex toto.php',
    'ErrorDocument 502 /var/www/helldorado/502.html',
    'ErrorDocument 403 http://helldorado.info/missing/403.html',
    'AuthType Digest',
    'AuthName "kitchen iz gud"',
    'AuthDigestAlgorithm MD5',
    'AuthDigestDomain / /toto /titi',
    'AuthDigestNonceLifetime 400',
    'AuthDigestProvider file',
    'AuthDigestQop auth',
    'AuthBasicAuthoritative off',
    'AuthBasicProvider file',
    'AuthUserFile /opt/.htpasswd',
    'AuthGroupFile /opt/.htpasswd.grp',
    'FallbackResource none.php',
    'ExpiresActive on',
    'ExpiresDefault "modification plus 3 weeks"',
    'ExpiresByType image/gif "access plus 2 days"',
    'ExpiresByType text/html "access plus 1 hours"',
    'ExtFilterOptions LogStderr',
    'ForceType text/plain',
    'SSLOptions +FakeBasicAuth -StrictRequire',
    'FcgidWrapper /usr/local/bin/php-wrapper .php virtual',
    'RewriteEngine On',
    '# Lynx or Mozilla v1/2',
    'RewriteCond %{HTTP_USER_AGENT} ^Lynx/ [OR]',
    'RewriteCond %{HTTP_USER_AGENT} ^Mozilla/[12]',
    'RewriteRule ^index\.html$ welcome.html',
    'RewriteBase /apps/',
    'SetEnv SPECIAL_PATH /foo/bin',
    'SetEnv LD_LIBRARY_PATH /usr/local/lib',
    'SetEnv newrelic.app_name "SPYNAL"',
    'SetOutputFilter INCLUDES',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'AllowOverride None',
    'IndexOptions titi toto tata',
    'IndexOrderDefault tutu',
    'IndexStyleSheet /opt/none.css',
    'AllowOverride Everything None',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
