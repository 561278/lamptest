require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/itk.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/itk.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/itk.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mpm_itk_module>',
      'StartServers        2',
      'MinSpareServers     25',
      'MaxSpareServers     75',
      'ServerLimit         25',
      'MaxClients          150',
      'MaxRequestsPerChild 0',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
