require 'serverspec'
set :backend, :exec

describe file('/var/www/setid') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/setid1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/setid1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/setid1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "setidone" env=DEBUG',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/setid2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/setid2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/setid2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'SetEnvIf Remote_Addr 192.168.0.1 DEBUG',
    'SetEnvIf Remote_Addr 10.0.0.1 DEBUG',
    'Header set X-Vhost-ID "setid2 " env=DEBUG',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/002-setid3.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/setid3.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/setid3.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "setidthree from /etc/apache2/sites-enabled/002-setid3.conf" env=DEBUG',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/setid4.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/setid4.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/setid4.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SetEnvIf Remote_Addr 127.0.0.1 DEBUG',
    'Header set X-Vhost-ID "setid4 from /etc/apache2/sites-enabled/setid4.conf" env=DEBUG',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
