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
      'SSLRandomSeed startup file:/dev/urandom 512',
      'SSLRandomSeed connect builtin',
      'SSLRandomSeed connect file:/dev/urandom 512',
      'AddType application/x-x509-ca-cert .crt',
      'AddType application/x-pkcs7-crl    .crl',
      'SSLPassPhraseDialog builtin',
      'SSLSessionCache "shmcb:${APACHE_RUN_DIR}/ssl_scache(512000)"',
      'SSLSessionCacheTimeout 300',
      'SSLCryptoDevice builtin',
      'SSLHonorCipherOrder On',
      'SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5:!RC4',
      'SSLProtocol all -SSLv2 -SSLv3',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'SSLOptions ',
      'SSLOpenSSLConfCmd ',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/ssl.conf'), :if => isApache24?() do
    [
      'Mutex default',
      'SSLCompression Off',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end