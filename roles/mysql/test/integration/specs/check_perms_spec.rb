require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')


describe file("/etc/mysql/my.cnf") do
    it { should be_file }
    it { should be_owned_by 'root' }

end

describe file("/root/.my.cnf") do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 400 }
end

describe file("/var/lib/mysql") do
    it { should be_directory }
    it { should be_owned_by 'mysql' }
end
