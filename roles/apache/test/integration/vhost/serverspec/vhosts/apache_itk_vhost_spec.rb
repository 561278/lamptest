require 'serverspec'
set :backend, :exec

describe file('/var/www/itk') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/itkdefault.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/itkdefault.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/itkdefault.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<IfModule mpm_itk_module>',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'AssignUserId',
    'AssignUserIdExpr',
    'AssignGroupIdExpr',
    'MaxClientsVHost',
    'NiceValue',
    'LimitUIDRange',
    'LimitGIDRange',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/itkvars.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/itkvars.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/itkvars.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<IfModule mpm_itk_module>',
    'AssignUserId dummy dummy',
    'AssignUserIdExpr %{HOST}',
    'AssignGroupIdExpr %{HOST}',
    'MaxClientsVHost 3',
    'NiceValue 4',
    'LimitUIDRange 1000 2000',
    'LimitGIDRange 1000 2000',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end
