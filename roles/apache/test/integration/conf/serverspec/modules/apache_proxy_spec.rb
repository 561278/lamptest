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

describe file('/etc/apache2/mods-enabled/proxy.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/proxy.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/proxy.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/proxy.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/proxy.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/proxy.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_proxy.c>',
      'ProxyRequests On',
      'ProxyVia On',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/proxy.conf'), :if => ! isApache24?() do
    [
      'Order deny,allow',
      'Deny from all',
      'Allow from 127.0.0.1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/proxy.conf'), :if => isApache24?() do
    [
      'Require ip 127.0.0.1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
