require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/sites-enabled/rewrite3.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/rewrite3.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end

describe file('/etc/apache2/sites-available/rewrite3.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'DocumentRoot',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end