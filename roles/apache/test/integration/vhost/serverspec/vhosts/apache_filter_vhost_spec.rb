require 'serverspec'
set :backend, :exec

describe file('/var/www/filter') do
  it { should be_directory }
end

if os[:family] == 'debian' && os[:release] =~ /7\../
  vhost_content = [
    '<VirtualHost *:80>',
    'FilterDeclare  gzip CONTENT_SET',
    'FilterProtocol gzip change=yes;byteranges=no',
    'FilterProvider gzip DEFLATE resp=Content-Type $text/html',
    'FilterChain    gzip'
  ]
else
  vhost_content = [
    '<VirtualHost *:80>',
    'FilterDeclare  COMPRESS',
    'FilterProvider COMPRESS DEFLATE "%{Content_Type} = \\"text/html\\""',
    'FilterChain    COMPRESS',
    'FilterProtocol COMPRESS DEFLATE change=yes;byteranges=no'
  ]
end

describe file('/etc/apache2/sites-enabled/filter.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/filter.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/filter.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  vhost_content.each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
