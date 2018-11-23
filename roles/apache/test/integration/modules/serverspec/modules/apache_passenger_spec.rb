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

describe file('/etc/apache2/mods-enabled/passenger.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/passenger.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/passenger.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/passenger.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/passenger.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/passenger.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_passenger.c>',

    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'PassengerHighPerformance ',
      'PassengerMaxPoolSize ',
      'PassengerMinInstances ',
      'PassengerPoolIdleTime ',
      'PassengerMaxRequestQueueSize ',
      'PassengerMaxRequests ',
      'PassengerSpawnMethod ',
      'PassengerStatThrottleRate ',
      'PassengerUseGlobalQueue ',
      'PassengerAppEnv ',
      'PassengerDebugLogFile ',
      'RackAutoDetect ',
      'RailsAutoDetect ',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/passenger.conf'), :if => ! isApache24?() && os[:family] == 'debian' do
    [
      'PassengerRuby "/usr/bin/ruby"',
      'PassengerRoot "/usr"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'PassengerDefaultRuby "',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/passenger.conf'), :if => isApache24?() && os[:family] == 'debian' do
    [
      'PassengerDefaultRuby "/usr/bin/ruby"',
      'PassengerRoot "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'PassengerRuby "',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/passenger.conf'), :if => os[:family] == 'ubuntu' do
    [
      'PassengerDefaultRuby "/usr/bin/ruby"',
      'PassengerRoot "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'PassengerRuby "',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end