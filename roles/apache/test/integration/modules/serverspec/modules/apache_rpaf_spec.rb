require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/rpaf.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/rpaf.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/rpaf.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/rpaf.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/rpaf.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/rpaf.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'RPAFenable On',
      'RPAFproxy_ips    127.0.0.1',
      'RPAFheader      X-Forwarded-For',
      'RPAFsethostname On',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
