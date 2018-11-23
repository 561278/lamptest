require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/dir.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/dir.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/dir.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/dir.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/dir.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/dir.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end