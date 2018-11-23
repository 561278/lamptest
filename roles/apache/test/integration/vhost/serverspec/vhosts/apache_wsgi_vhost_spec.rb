require 'serverspec'
set :backend, :exec

describe file('/var/www/wsgi') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/wsgi1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/wsgi1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/wsgi1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'WSGIApplicationGroup %{GLOBAL}',
    'WSGIDaemonProcess wsgi  processes=2  threads=15  display-name=%{GROUP}',
    'WSGIImportScript /var/www//python-app/abstract.wsgi  application-group=%{GLOBAL}  process-group=wsgi',
    'WSGIProcessGroup wsgi',
    'WSGIScriptAlias / "/var/www/python-app/appliance.wsgi"',
    'WSGIScriptAlias /combo "/var/www/python-app/combo.wsgi"',
    'WSGIPassAuthorization on',
    'WSGIChunkedRequest on',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/wsgi2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/wsgi2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/wsgi2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'WSGIApplicationGroup ',
    'WSGIDaemonProcess ',
    'WSGIImportScript ',
    'WSGIProcessGroup ',
    'WSGIScriptAlias ',
    'WSGIScriptAlias ',
    'WSGIPassAuthorization ',
    'WSGIChunkedRequest ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
