require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')

describe command('mysql --version') do
    its(:stdout) { should match /Distrib #{cfg['mysql_version']}\..*/ }
end
