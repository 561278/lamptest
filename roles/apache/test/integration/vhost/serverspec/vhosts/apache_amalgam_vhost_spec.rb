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

describe file('/etc/apache2/sites-enabled/098-amalgam.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/amalgam.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/amalgam.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<VirtualHost *:80>',
    'ServerName www.amalgam.non-existent',
    'ServerAdmin admin@amalgam.non-existent',
    'ServerAlias amalgam.non-existent',
    'ServerAlias non-existent',
    'ServerAlias sabrewulf.amalgam.non-existent fulgor.amalgam.non-existent raiden.amalgam.non-existent',
    'ServerAlias www.non-existent',
    'VirtualDocumentRoot "/var/www/amalgam"',
    'Header set my-custom-header "%D %t"',
    'Header merge Cache-Control no-cache env=NO_CACHE',
    'RequestHeader edit Destination ^https: http: early',
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "www.amalgam.non-existent" env=DEBUG',
    'Action image/gif /cgi-bin virtual',
    'AllowEncodedSlashes On',
    'AddDefaultCharset utf-8',
    'SetEnv SPECIAL_PATH /foo/bin',
    'SetEnv LD_LIBRARY_PATH /usr/local/lib',
    'SetEnv newrelic.app_name "SPYNAL"',
    'SetEnvIf Request_URI "\.gif$" object_is_image=gif',
    'SetEnvIf object_is_image xbm XBIT_PROCESSING=1',
    'PassEnv SPECIAL_PATH newrelic.app_name',
    'UnsetEnv LD_LIBRARY_PATH SHLVL',
    'ErrorDocument 503 /var/www/helldorado/503.html',
    'ErrorDocument 404 http://helldorado.info/missing/404.html',
    'FallbackResource /index.html',
    'Redirect permanent "/images/" "http://static.helldorado.info/"',
    'Redirect  "/downloads" "http://download.helldorado.info/"',
    'RedirectMatch  "\.git(/.*|$)/" "http://gitlab.helldorado.info/"',
    'RedirectMatch temp "(.*)\.gif$" "http://helldorado.info/gif/$1.gif"',
    'SuexecUserGroup webhoster combo',
    'DirectoryIndex index.php index.html index.rb',
    'DirectorySlash Off',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'DocumentRoot',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-available/amalgam.conf'), :if => ! isApache24?() do
  [
    'Include "/etc/apache2/rewrite.conf"',
    'Include "/etc/apache2/security.conf"',
    'Include "/etc/apache2/probe.conf"',
  ].each do |line|
    its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'DirectoryIndexRedirect off',
    'DirectoryCheckHandler On',
  ].each do |line|
    its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/amalgam.conf'), :if => isApache24?() do
  [
    'IncludeOptional "/etc/apache2/rewrite.conf"',
    'IncludeOptional "/etc/apache2/security.conf"',
    'IncludeOptional "/etc/apache2/probe.conf"',
    'DirectoryIndexRedirect off',
    'DirectoryCheckHandler On',
  ].each do |line|
    its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
