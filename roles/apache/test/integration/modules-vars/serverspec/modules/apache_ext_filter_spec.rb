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
      'ExtFilterDefine slowdown mode=output cmd=/bin/cat preservescontentlength',
      'ExtFilterDefine tracebefore cmd="/bin/tracefilter.pl /tmp/tracebefore" EnableEnv=trace_this_client',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end