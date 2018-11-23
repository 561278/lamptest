require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/wsgi.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/wsgi.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/wsgi.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/wsgi.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/wsgi.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/wsgi.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_wsgi.c>',
      'WSGISocketPrefix py',
      'WSGIPythonHome "/opt"',
      'WSGIPythonPath "/usr/bin/python"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
