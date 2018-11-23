require 'serverspec'
set :backend, :exec

describe file('/var/www/rack') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/rack.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/rack.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/rack.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'RackBaseURI /totototo',
    'RackBaseURI /tatatata',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
