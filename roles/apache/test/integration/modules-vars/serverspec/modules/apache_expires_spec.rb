require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/expires.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/expires.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/expires.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/expires.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/expires.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/expires.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'ExpiresActive   Off',
      'ExpiresDefault  "modification plus 24 seconds"',
      'ExpiresByType   text/plain "modification plus 1 week"',
      'ExpiresByType   application/json "access plus 30 seconds"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end