require 'serverspec'
set :backend, :exec

describe file('/var/www/sslproxy') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/sslproxy1.conf')  do
  it { should_not exist }
end
describe file('/etc/apache2/sites-available/sslproxy1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SSLProxyEngine On',
    'SSLProxyVerify require',
    'SSLProxyCheckPeerCN     off',
    'SSLProxyCheckPeerName   off',
    'SSLProxyMachineCertificateFile "/opt/certs/toto.crt"',
    'SSLProxyMachineCertificateChainFile "/opt/certs/ca.cert"',
    'SSLProxyProtocol  all -SSLv3',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
