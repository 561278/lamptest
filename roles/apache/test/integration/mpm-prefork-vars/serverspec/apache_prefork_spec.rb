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

describe file('/etc/apache2/mods-enabled/prefork.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/prefork.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/prefork.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'ServerLimit         28',
      'StartServers        4',
      'MinSpareServers     34',
      'MaxSpareServers     78',
      'ListenBacklog       510',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/prefork.conf'), :if => ! isApache24?() do
    [
      'MaxClients          160',
      'MaxRequestsPerChild 1000',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/prefork.conf'), :if => isApache24?() do
    [
      'MaxRequestWorkers   170',
      'MaxConnectionsPerChild 1001',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end