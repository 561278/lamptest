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

describe file('/etc/apache2/mods-enabled/ldap.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/ldap.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/ldap.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/ldap.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/ldap.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/ldap.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<Location /ldap-status>',
      'SetHandler ldap-status',
      'LDAPTrustedGlobalCert KEY_BASE64 /opt/certs/toto.key',
      'LDAPSharedCacheSize 4096',
      'LDAPCacheEntries 512',
      'LDAPCacheTTL 20',
      'LDAPOpCacheEntries 1024',
      'LDAPOpCacheTTL 40',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/ldap.conf'), :if => ! isApache24?() do
    [
      'Order deny,allow',
      'Deny from all',
      'Allow from 127.0.0.1 ::1',
      'Satisfy all',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/ldap.conf'), :if => isApache24?() do
    [
      'Require ip 127.0.0.1 ::1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end