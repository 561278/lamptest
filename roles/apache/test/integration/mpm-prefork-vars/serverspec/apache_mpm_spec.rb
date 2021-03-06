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

describe package('apache2'), :if => isApache24?() do
    it { should be_installed }
end

describe package('apache2.2-common'), :if => ! isApache24?() do
    it { should be_installed }
end

describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
end

describe package('apache2-mpm-prefork') do
    it { should be_installed }
end

describe file('/etc/apache2/mods-enabled/mpm_event.conf') do
    it { should_not exist }
end

describe file('/etc/apache2/mods-enabled/mpm_event.load') do
    it { should_not exist }
end
