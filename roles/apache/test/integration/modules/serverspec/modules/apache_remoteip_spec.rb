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

describe file('/etc/apache2/mods-enabled/remoteip.load'), :if => isApache24?() do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/remoteip.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/remoteip.load'), :if => isApache24?() do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/remoteip.conf'), :if => isApache24?() do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/remoteip.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/remoteip.conf'), :if => isApache24?() do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'RemoteIPHeader        X-Forwarded-For',
      'RemoteIPInternalProxy 127.0.0.1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'RemoteIPProxiesHeader ',
      'RemoteIPTrustedProxy  ',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
