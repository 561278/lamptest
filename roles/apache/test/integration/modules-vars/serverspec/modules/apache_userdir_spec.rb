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

describe file('/etc/apache2/mods-enabled/userdir.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/userdir.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/userdir.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/userdir.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/userdir.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/userdir.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_userdir.c>',
      'UserDir /var/*/html',
      '<Directory "/var/*/html">',
      'AllowOverride FileInfo AuthConfig Limit Indexes',
      'Options -Indexes',
      '<Limit GET POST OPTIONS>',
      '<LimitExcept GET POST OPTIONS>',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'UserDir disabled root',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/userdir.conf'), :if => ! isApache24?() do
    [
      'Order allow,deny',
      'Allow from all',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/userdir.conf'), :if => isApache24?() do
    [
      'Require all granted',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end