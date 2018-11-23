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

describe file('/var/www/fastcgi') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/fastcgidefault.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/fastcgidefault.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/fastcgidefault.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
      'FastCGIExternalServer /fastcgi-pool-fastcgidefault -idle-timeout 30 -flush -socket /var/run/php5-fpm.sock -pass-header Authorization',
      'Alias  /usr/lib/cgi-bin/fastcgidefault /fastcgi-pool-fastcgidefault',
      'Action application/x-httpd-php-fastcgidefault /usr/lib/cgi-bin/fastcgidefault',
      'AddType application/x-httpd-php-fastcgidefault .php',
      'AllowEncodedSlashes On',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
      '<LocationMatch "/',
      'SetHandler php-fcgi-virt',
      'Action php-fcgi-virt ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/fastcgi1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/fastcgi1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/fastcgi1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
      'FastCGIExternalServer /Fcgiptest -idle-timeout 30 -socket /var/run/php.sock -pass-header X-PHP',
      'Alias  /usr/lib/cgi-bin/toto /Fcgiptest',
      'Action app/php /usr/lib/cgi-bin/toto',
      'AddType app/php .php',
      'AllowEncodedSlashes On',
      '<LocationMatch "/(st|p)">',
      'SetHandler php-fcgi-virt',
      'Action php-fcgi-virt /usr/lib/cgi-bin/toto virtual',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/fastcgi1.conf'), :if => isApache24?() do
  [
    'Require all granted',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'Order Deny,Allow',
    'Deny from All',
    'Allow from 10.0.0.5',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/fastcgi1.conf'), :if => ! isApache24?() do
  [
    'Order Deny,Allow',
    'Deny from All',
    'Allow from 10.0.0.5',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
      'Require all granted',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/fastcgi2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/fastcgi2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/fastcgi2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
      'FastCGIExternalServer /fastcgi-pool-fastcgi2 -idle-timeout 30 -flush -host 127.0.0.1:9000 -pass-header Authorization',
      'Alias  /usr/lib/cgi-bin/fastcgi2 /fastcgi-pool-fastcgi2',
      'Action application/x-httpd-php-fastcgi2 /usr/lib/cgi-bin/fastcgi2',
      'AddType application/x-httpd-php-fastcgi2 .php',
      'AllowEncodedSlashes On',
      '<LocationMatch "/(fpm-status|fpm-ping)">',
      'SetHandler php-fcgi-virt',
      'Action php-fcgi-virt /usr/lib/cgi-bin/fastcgi2 virtual',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/fastcgi2.conf'), :if => ! isApache24?() do
  [
    'Allow from 127.0.0.1',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
