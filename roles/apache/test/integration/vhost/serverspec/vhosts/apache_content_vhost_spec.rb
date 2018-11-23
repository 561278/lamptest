require 'serverspec'
set :backend, :exec

describe file('/var/www/content1') do
  it { should be_directory }
end

describe file('/var/www/content1/index.html')  do
  it { should be_file }
  it { should be_owned_by 'www-data' }
  its(:content) { should match /^\s*#{Regexp.escape('<h>Your webserver works !</h>')}/ }
end

describe file('/var/www/content2') do
  it { should be_directory }
end

describe file('/var/www/content2/index.html')  do
  it { should be_file }
  it { should be_owned_by 'dummy' }
  it { should be_mode 777 }
  its(:content) { should match /^\s*#{Regexp.escape('<h>Your webserver works !</h>')}/ }
end


describe file('/var/www/content3') do
  it { should be_directory }
end

describe file('/var/www/content3/index.html')  do
  it { should be_file }
  it { should be_owned_by 'www-data' }
  its(:content) { should match /^\s*#{Regexp.escape('it works')}/ }
end

describe file('/var/www/content4') do
  it { should be_directory }
end

describe file('/var/www/content4/index.html')  do
  it { should be_file }
  it { should be_owned_by 'dummy' }
  it { should be_mode 777 }
  its(:content) { should match /^\s*#{Regexp.escape('it works')}/ }
end

