require 'serverspec'
set :backend, :exec

describe file('/var/www/empty') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/empty.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/empty.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/empty.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<VirtualHost *:80>',
    'ServerName empty',
    'DocumentRoot  "/var/www/empty"',
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "empty" env=DEBUG'
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'ServerAdmin',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
