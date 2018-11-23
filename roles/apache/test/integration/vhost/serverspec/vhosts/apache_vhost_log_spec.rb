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

describe file('/var/www/log') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/log1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/log1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/log1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'LogFormat "%t - %a" test',
    'CustomLog "/var/log/apache2/access_helldorado.log" test',
    'ErrorLog "/var/log/apache2/helldorado.log"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogLevel',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/log2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/log2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/log2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'LogLevel "warn"',
    'ErrorLog "/var/log/apache2/helldorado.log"',
    'LogFormat "%t - %a" test',
    'CustomLog "/var/log/apache2/access_helldorado.log" test',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/log3.conf') do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/log3.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/log3.conf'), :if => isApache24?() do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ErrorLog "|/bin/false"',
    'LogFormat \'%{X-Forwarded-For}i %h %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i" %b %D %T %P %V:%p\' syslog',
    'CustomLog "|/bin/sh -c \'logger -p local7.info -t apache_access_log\'"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogLevel',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/log3.conf'), :if => ! isApache24?() do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ErrorLog "|/bin/false"',
    'LogFormat \'%{X-Forwarded-For}i %h %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i" %b %D %T %P %V:%p\' syslog',
    'CustomLog "|logger -p local7.info -t apache_access_log"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogLevel',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/log4.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/log4.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/log4.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ErrorLog "/var/log/apache2/log4_error.log"',
    'LogFormat \'%{X-Forwarded-For}i %h %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i" %b %D %T %P %V:%p\' custom_vhost_log',
    'CustomLog "|/bin/false" custom_vhost_log',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogLevel',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/log5.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/log5.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/log5.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ErrorLog "/var/log/apache2/log5_error.log"',
    'LogFormat \'%{X-Forwarded-For}i %h %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i" %b %D %T %P %V:%p\' custom_vhost_log',
    'CustomLog "/var/log/apache2/log5_access.log" custom_vhost_log',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogLevel',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/log6.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/log6.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/log6.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ErrorLog "/var/log/apache2/logsix_error.log"',
    'LogFormat \'%{X-Forwarded-For}i %h %l %u %t "%r" %>s %O "%{Referer}i" "%{User-Agent}i" %b %D %T %P %V:%p\' custom_vhost_log',
    'CustomLog "/var/log/apache2/logsix_access.log" custom_vhost_log'
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogLevel',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/logdefault.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/logdefault.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/logdefault.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'LogFormat ',
    'CustomLog "" ',
    'LogLevel',
    'ErrorLog'
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/var/log/apache2/log7-error') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end
describe file('/var/log/apache2/log7-access') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end
describe file('/var/log/apache2/log8-error') do
  it { should be_directory }
  it { should be_owned_by 'webhoster' }
  it { should be_grouped_into 'adm' }
end
describe file('/var/log/apache2/log8-access') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'combo' }
end
