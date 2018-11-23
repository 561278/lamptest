require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/dav_fs.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/dav_fs.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/dav_fs.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/dav_fs.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/dav_fs.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/dav_fs.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'DAVLockDB "/opt/dav.lock"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end