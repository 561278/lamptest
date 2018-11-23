require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/auth_cas.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/auth_cas.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/auth_cas.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/auth_cas.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/auth_cas.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/auth_cas.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'CASCookiePath         /var/cache/apache2/mod_auth_cas/',
      'CASLoginURL           https://login.example.org/cas/login',
      'CASValidateURL        https://login.example.org/cas/validate',
      'CASVersion            1',
      'CASDebug              On',
      'CASCertificatePath    /opt/certs',
      'CASProxyValidateURL   http://unimplemented.com/no',
      'CASValidateDepth      3',
      'CASRootProxiedAs      http://internal.example.com',
      'CASCookieEntropy      16',
      'CASTimeout            15',
      'CASIdleTimeout        120',
      'CASCacheCleanInterval 2400',
      'CASCookieDomain       toto.foo',
      'CASCookieHttpOnly     On',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end