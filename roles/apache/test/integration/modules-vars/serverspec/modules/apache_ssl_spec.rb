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

describe file('/etc/apache2/mods-enabled/ssl.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/ssl.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/ssl.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/ssl.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/ssl.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/ssl.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_ssl.c>',
      'SSLRandomSeed startup builtin',
      'SSLRandomSeed startup file:/dev/urandom 1024',
      'SSLRandomSeed connect builtin',
      'SSLRandomSeed connect file:/dev/urandom 1024',
      'AddType application/x-x509-ca-cert .crt',
      'AddType application/x-pkcs7-crl    .crl',
      'SSLPassPhraseDialog |/bin/false',
      'SSLSessionCache "shmcb:/tmp/totosession"',
      'SSLSessionCacheTimeout 450',
      'SSLCryptoDevice dynamic',
      'SSLHonorCipherOrder Off',
      'SSLCipherSuite DEFAULT',
      'SSLProtocol all -SSLv3 -TLSv1',
      'SSLOptions -StrictRequire -OptRenegotiate',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/ssl.conf'), :if => ! isApache24?() do
    [
      'SSLMutex pthread',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/ssl.conf'), :if => isApache24?() do
    [
      'Mutex pthread',
      'SSLCompression On',
      '#SSLOpenSSLConfCmd ECDHParameters brainpoolP256r1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end