require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/mime_magic.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/mime_magic.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/mime_magic.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/mime_magic.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/mime_magic.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/mime_magic.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_mime_magic.c>',
      'MIMEMagicFile "/opt/empty.file"',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
