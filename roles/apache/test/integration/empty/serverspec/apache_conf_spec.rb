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
      'ServerTokens Prod',
      'ServerSignature Off',
      'TraceEnable Off',
      'ServerName apache',
      'ServerRoot /etc/apache2',
      'PidFile ${APACHE_PID_FILE}',
      'Timeout 300',
      'KeepAlive Off',
      'MaxKeepAliveRequests 100',
      'KeepAliveTimeout 15',
      'LimitRequestFieldSize 8190',
      'User www-data',
      'Group www-data',
      'AccessFileName .htaccess',
      '<FilesMatch "^\.ht">',
      '<Directory />',
      'Options FollowSymLinks',
      'AllowOverride None',
      'HostnameLookups Off',
      'LogLevel warn',
      'EnableSendfile On',
      'Include "/etc/apache2/mods-enabled/*.load"',
      'Include "/etc/apache2/mods-enabled/*.conf"',
      'Include "/etc/apache2/ports.conf"',
      'LogFormat "%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\" %b %D %T %P %V:%p" syslog',
      'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
      'Header set X-Apache-Server-ID "localhost" env=DEBUG',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'RewriteLock ',
      'AddDefaultCharset ',
      'AllowEncodedSlashes ',
      'Alias /error/ ',
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
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/apache2.conf'), :if => ! isApache24?() do
    [
      'Order allow,deny',
      'Deny from all',
      'Satisfy all',
      'DefaultType None',
      'CustomLog "|logger -p local7.info -t apache_access_log" syslog',
      'ErrorLog  "|logger -p local7.err -t apache_error_log"',
      'Include "/etc/apache2/conf.d/*.conf"',
      'Include "/etc/apache2/sites-enabled/*.conf"',
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
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'Require all granted',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end

describe file('/etc/apache2/ports.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 444 }
    [
      'Listen *:80',
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
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      '# Vulnerability Scanners',
      '# Cyveillance',
      '# Agressive IP',
      '# Agressive Hosts',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/conf.d/badbot.conf'), :if => ! isApache24?() do
    [
      'Deny from env=bad_bot',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/conf.d/badbot.conf'), :if => isApache24?() do
    [
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
      '<DirectoryMatch ".*\.(svn|git|bzr)/.*">',
      '<FilesMatch "(\.(bak|config|sql|ini|log|sh|inc|swp)|~)$">',
      'RequestHeader unset Proxy',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end

describe file('/etc/apache2/conf.d/other-vhosts-access-log') do
  it { should_not exist }
end

describe file('/var/www/index.html') do
  it { should_not exist }
end

describe file('/etc/apache2/mods-enabled/security.conf') do
    it { should_not exist }
end
