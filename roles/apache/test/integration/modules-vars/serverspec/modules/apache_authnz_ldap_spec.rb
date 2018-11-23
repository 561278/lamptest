require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/authnz_ldap.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/authnz_ldap.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/authnz_ldap.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/authnz_ldap.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/authnz_ldap.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/authnz_ldap.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'LDAPVerifyServerCert On',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end