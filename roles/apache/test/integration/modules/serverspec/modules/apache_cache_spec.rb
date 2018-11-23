require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/cache.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/cache.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/cache.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/cache.conf') do
    it { should_not exist }
end
describe file('/etc/apache2/mods-available/cache.conf') do
    it { should_not exist }
end