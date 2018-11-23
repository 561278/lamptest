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

describe file('/var/www/passenger') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/passengerdefault.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/passengerdefault.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/passengerdefault.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'PassengerBaseURI ',
    'PassengerBaseURI ',
    'PassengerBaseURI ',
    'PassengerAppRoot ',
    'PassengerAppEnv ',
    'PassengerRuby ',
    'PassengerMinInstances ',
    'PassengerStartTimeout ',
    'PassengerPreStart ',
    'PassengerUser ',
    'PassengerGroup ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/passengervars.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/passengervars.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/passengervars.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'PassengerAppRoot /rubyis',
    'PassengerRuby 2.2',
    'PassengerMinInstances 1',
    'PassengerPreStart 12',
    'PassengerUser dummy',
    'PassengerGroup dummy',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/passengervars.conf'), :if => isApache24?() do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'PassengerBaseURI /toto',
    'PassengerBaseURI /titi',
    'PassengerBaseURI /tutu',
    'PassengerStartTimeout 120',
    'PassengerAppEnv prod',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/passengervars.conf'), :if => ! isApache24?() do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'PassengerBaseURI /toto',
    'PassengerBaseURI /titi',
    'PassengerBaseURI /tutu',
    'PassengerStartTimeout 120',
    'PassengerAppEnv prod',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end





