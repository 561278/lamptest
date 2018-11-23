require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')


# check service is running
if os[:family] == 'redhat' then
    php_prefix = 'php'
elsif cfg['php_version'] == '7.0' then
    php_prefix = 'php7.0'
elsif cfg['php_version'] == '7.1' then
    php_prefix = 'php7.1'
elsif cfg['php_version'] == '5.6' and os[:family] == 'ubuntu' and os[:release] == '14.04' then
    php_prefix = 'php5.6'
elsif cfg['php_version'] == '5.6' and os[:family] == 'debian' and os[:release] >= '9' then
      php_prefix = 'php5.6'
else
    php_prefix = 'php5'
end

describe package("#{php_prefix}-fpm") do
    it { should be_installed }
end

describe service("#{php_prefix}-fpm") do
  it { should be_enabled }
end
describe service("#{php_prefix}-fpm") do
  it { should be_running }
end
