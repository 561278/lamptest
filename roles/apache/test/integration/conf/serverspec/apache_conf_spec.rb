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

describe file('/etc/apache2/apache2.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 444 }
    [
      'ServerTokens Minor',
      'ServerSignature EMail',
      'TraceEnable extended',
      'ServerName Mouarf',
      'ServerRoot /etc/apache2',
      'Timeout 60',
      'KeepAlive On',
      'MaxKeepAliveRequests 1000',
      'KeepAliveTimeout 30',
      'LimitRequestFieldSize 4096',
      'AccessFileName .htaccess',
      '<FilesMatch "^\.ht">',
      '<Directory />',
      'Options All',
      'AddDefaultCharset utf-8',
      'AllowOverride None',
      'HostnameLookups Off',
      'LogLevel debug',
      'EnableSendfile Off',
      'AllowEncodedSlashes  Off',
      'Include "/etc/apache2/mods-enabled/*.load"',
      'Include "/etc/apache2/mods-enabled/*.conf"',
      'Include "/etc/apache2/ports.conf"',
      'LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined',
      'LogFormat "%h %l %u %t \"%r\" %>s %b" common',
      'LogFormat "%{Referer}i -> %U" referer',
      'LogFormat "%{User-agent}i" agent',
      'LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-agent}i\"" forwarded',
      'LogFormat "%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\" %b %D %T %P %V:%p" syslog',
      '# /usr/share/apache2/error on debian',
      'Alias /error/ "/usr/share/apache2/error/"',
      '<Directory "/usr/share/apache2/error">',
      'Options IncludesNoExec',
      'AddOutputFilter Includes html',
      'AddHandler type-map var',
      'LanguagePriority en cs de es fr it nl sv pt-br ro',
      'ForceLanguagePriority Prefer Fallback',
      'ErrorDocument 400 /error/HTTP_BAD_REQUEST.html.var',
      'ErrorDocument 401 /error/HTTP_UNAUTHORIZED.html.var',
      'ErrorDocument 403 /error/HTTP_FORBIDDEN.html.var',
      'ErrorDocument 404 /error/HTTP_NOT_FOUND.html.var',
      'ErrorDocument 405 /error/HTTP_METHOD_NOT_ALLOWED.html.var',
      'ErrorDocument 408 /error/HTTP_REQUEST_TIME_OUT.html.var',
      'ErrorDocument 410 /error/HTTP_GONE.html.var',
      'ErrorDocument 411 /error/HTTP_LENGTH_REQUIRED.html.var',
      'ErrorDocument 412 /error/HTTP_PRECONDITION_FAILED.html.var',
      'ErrorDocument 413 /error/HTTP_REQUEST_ENTITY_TOO_LARGE.html.var',
      'ErrorDocument 414 /error/HTTP_REQUEST_URI_TOO_LARGE.html.var',
      'ErrorDocument 415 /error/HTTP_UNSUPPORTED_MEDIA_TYPE.html.var',
      'ErrorDocument 500 /error/HTTP_INTERNAL_SERVER_ERROR.html.var',
      'ErrorDocument 501 /error/HTTP_NOT_IMPLEMENTED.html.var',
      'ErrorDocument 502 /error/HTTP_BAD_GATEWAY.html.var',
      'ErrorDocument 503 /error/HTTP_SERVICE_UNAVAILABLE.html.var',
      'ErrorDocument 506 /error/HTTP_VARIANT_ALSO_VARIES.html.var',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
      'Header set X-Apache-Server-ID "localhost" env=DEBUG',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/apache2.conf'), :if => ! isApache24?() do
    [
      'DefaultType text/plain',
      'Order allow,deny',
      'Deny from all',
      'Satisfy all',
      'CustomLog "|logger -p local7.info -t apache_access_log" syslog',
      'ErrorLog  "|logger -p local7.err -t apache_error_log"',
      'Include "/etc/apache2/conf.d/*.conf"',
      'Include "/etc/apache2/sites-enabled/*.conf"',
      'Include "/etc/apache2/custom_config/*.conf"',
      'Include "/etc/apache2/awh/*.conf"',
      'Include "/var/www/client1_vhosts/*.conf"',
      'Include "/var/www/client2_vhosts/*.conf"',
      'Include "/var/www/vhosts/*.conf"',
      'RewriteLock /tmp/apacherewritelock',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/apache2.conf'), :if => isApache24?() do
    [
      'Require all denied',
      'CustomLog "|/bin/sh -c \'logger -p local7.info -t apache_access_log\'" syslog',
      'ErrorLog  "|/bin/sh -c \'logger -p local7.err -t apache_error_log\'"',
      'IncludeOptional "/etc/apache2/conf.d/*.conf"',
      'IncludeOptional "/etc/apache2/sites-enabled/*.conf"',
      'IncludeOptional "/etc/apache2/custom_config/*.conf"',
      'IncludeOptional "/etc/apache2/awh/*.conf"',
      'IncludeOptional "/var/www/client1_vhosts/*.conf"',
      'IncludeOptional "/var/www/client2_vhosts/*.conf"',
      'IncludeOptional "/var/www/vhosts/*.conf"',
      'Mutex file:/tmp/apacherewritelock',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      #'Require all granted',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end

describe file('/etc/apache2/ports.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 444 }
    [
      'Listen *:8080',
      'Listen *:8443',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end

describe file('/etc/apache2/conf.d/badbot.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 444 }
    [
      'SetEnvIfNoCase User-Agent "^True_Robot" bad_bot',
      'SetEnvIfNoCase User-Agent "^Microsoft" bad_bot',
      'SetEnvIfNoCase User-Agent "^ELinks" bad_bot',
      '# Vulnerability Scanners',
      'SetEnvIfNoCase User-Agent "Nikto" bad_bot',
      'SetEnvIfNoCase User-Agent "nmap" bad_bot',
      'SetEnvIfNoCase User-Agent "sqlbarbecue" bad_bot',
      '# Cyveillance',
      '# Agressive IP',
      '# Agressive Hosts',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/conf.d/badbot.conf'), :if => ! isApache24?() do
    [
       'Deny from 38.100.19.8/29',
       'Deny from 38.100.21.0/24',
       'Deny from 38.100.41.64/26',
       'Deny from 38.105.71.0/25',
       'Deny from 38.105.83.0/27',
       'Deny from 38.112.21.140/30',
       'Deny from 38.118.42.32/29',
       'Deny from 65.213.208.128/27',
       'Deny from 65.222.176.96/27',
       'Deny from 65.222.185.72/29',
       'Deny from 8.8.8.8',
       'Deny from 8.8.4.4',
       'Deny from google.com',
       'Deny from google.fr',
       'Deny from env=bad_bot',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/conf.d/badbot.conf'), :if => isApache24?() do
    [
       'Require not ip 38.100.19.8/29',
       'Require not ip 38.100.21.0/24',
       'Require not ip 38.100.41.64/26',
       'Require not ip 38.105.71.0/25',
       'Require not ip 38.105.83.0/27',
       'Require not ip 38.112.21.140/30',
       'Require not ip 38.118.42.32/29',
       'Require not ip 65.213.208.128/27',
       'Require not ip 65.222.176.96/27',
       'Require not ip 65.222.185.72/29',
       'Require not ip 8.8.8.8',
       'Require not ip 8.8.4.4',
       'Require not host google.com',
       'Require not host google.fr',
       'Require not env bad_bot',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end

describe file('/etc/apache2/conf.d/security.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 444 }
    [
      '<DirectoryMatch ".*\.(cvs|svk|svn|git|bzr)/.*">',
      '<FilesMatch "(\.(save|old|bak|config|sql|ini|log|sh|inc|swp)|~)$">',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'RequestHeader unset Proxy',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end

describe file('/etc/apache2/conf.d/other-vhosts-access-log') do
  it { should_not exist }
end

describe file('/var/www/index.html') do
  it { should_not exist }
end

describe file('/etc/apache2/custom_config') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end

describe file('/etc/apache2/awh') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end

describe file('/var/www/client1_vhosts') do
  it { should be_directory }
  it { should be_owned_by 'client1' }
end

describe file('/var/www/client2_vhosts') do
  it { should be_directory }
  it { should be_owned_by 'client2' }
end

describe file('/var/www/vhosts') do
  it { should be_directory }
  it { should be_owned_by 'www-data' }
end
