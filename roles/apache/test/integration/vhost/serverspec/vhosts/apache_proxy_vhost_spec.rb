require 'serverspec'
set :backend, :exec

describe file('/var/www/proxy') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/proxy1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/proxy1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/proxy1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ProxyPreserveHost On',
    'ProxyErrorOverride On',
    'ProxyPass /toto http://127.0.0.1',
    'ProxyPassReverse /toto http://127.0.0.1',
    'ProxyPass /titi http://127.0.0.2 retry=20 keepalive=on',
    'ProxyPassReverse /titi http://127.1.0.2',
    'ProxyPassReverse /titi http://127.1.0.3',
    'ProxyPass /tutu http://127.0.0.3  nocanon interpolate',
    'ProxyPassReverse /tutu http://127.0.0.3',
    'SetEnv proxy-nokeepalive 1',
    'ProxyBlock "news.example.com" "auctions.example.com" "friends.example.com"',
    'ProxyPass /tata http://127.0.0.4 retry=20 keepalive=on  nocanon interpolate',
    'ProxyPassReverseCookiePath /cookie http://gogol.fr',
    'ProxyPassReverseCookieDomain cookie.yum http://gogol.fr',
    'ProxyPassReverse /tata http://127.0.0.4',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/proxy2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/proxy2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/proxy2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ProxyPreserveHost Off',
    'ProxyPassMatch /riri http://127.0.0.1',
    'ProxyPassReverse /riri http://127.0.0.1',
    'ProxyPassMatch /roro http://127.0.0.2 retry=20 keepalive=on',
    'ProxyPassReverse /roro http://127.1.0.2',
    'ProxyPassReverse /roro http://127.1.0.3',
    'ProxyPassMatch /ruru http://127.0.0.3 nocanon interpolate',
    'ProxyPassReverse /ruru http://127.0.0.3',
    'SetEnv proxy-nokeepalive 1',
    'ProxyPassMatch /rara http://127.0.0.4 retry=20 keepalive=on nocanon interpolate',
    'ProxyPassReverse /rara http://127.0.0.4',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/proxy3.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/proxy3.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/proxy3.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ProxyPass        /not !',
    'ProxyPass        /through !',
    'ProxyPass        /proxy !',
    'ProxyPass        / http://127.3.0.1',
    'ProxyPassReverse / http://127.3.0.1',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/proxy4.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/proxy4.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/proxy4.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'ProxyPassMatch   /might !',
    'ProxyPassMatch   /none !',
    'ProxyPassMatch   /never !',
    'ProxyPassMatch   / http://127.4.0.1',
    'ProxyPassReverse / http://127.4.0.2',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
