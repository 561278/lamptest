require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/negotiation.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/negotiation.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/negotiation.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/negotiation.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/negotiation.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/negotiation.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_negotiation.c>',
      'LanguagePriority fr en cz',
      'ForceLanguagePriority Fallback',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
