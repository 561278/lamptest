require 'serverspec'
set :backend, :exec

describe file('/var/www/aliases') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/aliases.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/aliases.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/aliases.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'Alias /image "/ftp/pub/image"',
    'AliasMatch ^/image/(.*)\.jpg$ "/files/jpg.images/$1.jpg"',
    'ScriptAlias /nagios/cgi-bin/ "/usr/lib/nagios/cgi-bin/"',
    'ScriptAliasMatch ^/cgi-bin(.*) "/usr/local/share/cgi-bin$1"',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
