require 'serverspec'
set :backend, :exec

def isApache24?()
  if (os[:family] == 'debian' && ( os[:release] =~ /8\..*/ || os[:release] =~ /9\..*/ ) ) then
    return true
  elsif (os[:family] == 'ubuntu') then
    return true
  elsif (os[:family] == 'redhat' && os[:release] =~ /7\..*/) then
    return true
  end
  return false
end

if ! isApache24?() then
  module_name = 'disk_cache'
else
  module_name = 'cache_disk'
end

describe file("/etc/apache2/mods-enabled/#{module_name}.load") do
    it { should be_symlink }
    it { should be_linked_to "../mods-available/#{module_name}.load" }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file("/etc/apache2/mods-available/#{module_name}.load") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file("/etc/apache2/mods-enabled/#{module_name}.conf") do
    it { should be_symlink }
    it { should be_linked_to "../mods-available/#{module_name}.conf" }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file("/etc/apache2/mods-available/#{module_name}.conf") do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'CacheEnable disk /',
      'CacheRoot "/var/cache/apache2/mod_cache_disk"',
      'CacheDirLevels 2',
      'CacheDirLength 1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end