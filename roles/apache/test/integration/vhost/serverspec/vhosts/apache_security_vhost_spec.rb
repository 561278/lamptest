require 'serverspec'
set :backend, :exec

describe file('/var/www/security') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/security1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/security1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/security1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    '<LocationMatch /location1>',
    '</LocationMatch>',
    'SecRuleRemoveById 90015',
    'SecRuleRemoveById 90016',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'SecRuleEngine Off',
    'SecRule REMOTE_ADDR "',
    'SecAction  "phase:2,pass,nolog,id:1234123456"',
    'SecRequestBodyLimit ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/security2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/security2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/security2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'SecRuleEngine Off',
    'SecRule REMOTE_ADDR "8.8.8.8,8.8.4.4" "nolog,allow,id:1234123455"',
    'SecAction  "phase:2,pass,nolog,id:1234123456"',
    'SecRequestBodyLimit 4096',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    '<LocationMatch /location1>',
    '</LocationMatch>',
    'SecRuleRemoveById 90015',
    'SecRuleRemoveById 90016',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
