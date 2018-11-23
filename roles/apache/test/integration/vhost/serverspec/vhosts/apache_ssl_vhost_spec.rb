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

describe file('/var/www/ssl') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/ssl1.conf')  do
  it { should_not exist }
end
describe file('/etc/apache2/sites-available/ssl1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SSLEngine on',
    'SSLCertificateFile      "/opt/certs/sslone.crt"',
    'SSLCertificateKeyFile   "/opt/certs/sslone.key"',
    'SSLCertificateChainFile "/opt/certs/chain.cert"',
    'SSLCACertificatePath    "/opt/certs"',
    'SSLCACertificateFile    "/opt/certs/ca.cert"',
    'SSLCARevocationPath     "/opt/crl"',
    'SSLCARevocationFile     "/opt/crl/no.cert"',
    'SSLProtocol             all -SSLv3',
    'SSLCipherSuite          RSA:!EXP:!NULL:+HIGH:+MEDIUM:-LOW',
    'SSLHonorCipherOrder     on',
    'SSLVerifyClient         require',
    'SSLVerifyDepth          1',
    'SSLOptions +StdEnvVars -ExportCertData',
    '# SSLOpenSSLConfCmd       ECDHParameters brainpoolP256r1',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
describe file('/etc/apache2/sites-available/ssl1.conf'), :if => isApache24?() do
  [
    'SSLCARevocationCheck    "leaf"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/opt/certs') do
  it { should be_directory }
  it { should be_mode 700 }
  it { should be_owned_by 'root' }
end
describe file('/opt/certs/sslone.crt') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 400 }
end
describe file('/opt/certs/sslone.key') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 400 }
end

describe file('/etc/apache2/sites-enabled/ssl2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/ssl2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/ssl2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SSLEngine on',
    'SSLCertificateFile      "/etc/apache/ssl/certs/ssl2.crt"',
    'SSLCertificateKeyFile   "/etc/apache/ssl/certs/ssl2.key"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'SSLCertificateChainFile ',
    'SSLCACertificateFile ',
    'SSLCARevocationPath ',
    'SSLCARevocationFile ',
    'SSLCARevocationCheck ',
    'SSLProtocol ',
    'SSLCipherSuite ',
    'SSLHonorCipherOrder ',
    'SSLVerifyClient ',
    'SSLVerifyDepth ',
    'SSLOptions ',
    'SSLOpenSSLConfCmd ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache/ssl/certs') do
  it { should be_directory }
  it { should be_mode 700 }
  it { should be_owned_by 'root' }
end
describe file('/etc/apache/ssl/certs/ssl2.crt') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end
describe file('/etc/apache/ssl/certs/ssl2.key') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end

describe file('/etc/apache2/sites-enabled/ssl3.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/ssl3.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/ssl3.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SSLEngine on',
    'SSLCertificateFile      "/opt/certs/toto.crt"',
    'SSLCertificateKeyFile   "/opt/certs/toto.key"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'SSLCertificateChainFile ',
    'SSLCACertificatePath ',
    'SSLCACertificateFile ',
    'SSLCARevocationPath ',
    'SSLCARevocationFile ',
    'SSLCARevocationCheck ',
    'SSLProtocol ',
    'SSLCipherSuite ',
    'SSLHonorCipherOrder ',
    'SSLVerifyClient ',
    'SSLVerifyDepth ',
    'SSLOptions ',
    'SSLOpenSSLConfCmd ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/opt/certs/www.helldorado.info.cert') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 400 }
end
describe file('/opt/certs/www.helldorado.info.key') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 400 }
end
