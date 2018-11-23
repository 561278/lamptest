require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/deflate.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/deflate.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/deflate.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/deflate.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/deflate.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/deflate.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'AddOutputFilterByType   DEFLATE   text/html text/plain text/xml',
      'AddOutputFilterByType   DEFLATE   text/css',
      'AddOutputFilterByType   DEFLATE   application/x-javascript application/javascript application/ecmascript',
      'AddOutputFilterByType   DEFLATE   application/rss+xml',
      'AddOutputFilterByType   DEFLATE   application/json',
      'DeflateFilterNote       Input     instream',
      'DeflateFilterNote       Output    outstream',
      'DeflateFilterNote       Ratio     ratio',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end