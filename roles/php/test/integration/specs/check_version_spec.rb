require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')


describe command('php --version') do
    its(:stdout) { should match /PHP #{cfg['php_version']}\..*/ }
end

