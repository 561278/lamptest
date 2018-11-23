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

describe package('apache2-mpm-event') do
    it { should be_installed }
end
