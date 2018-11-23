require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/cgid.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/cgid.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/cgid.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/cgid.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/cgid.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/cgid.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'ScriptSock "/opt/cgid.sock"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end