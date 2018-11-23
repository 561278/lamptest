require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/ext_filter.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/ext_filter.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/ext_filter.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/ext_filter.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/ext_filter.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/ext_filter.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'ExtFilterDefine ',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end