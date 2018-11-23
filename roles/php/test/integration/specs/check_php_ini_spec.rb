require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')


if cfg['php_version'] == '5.6' and os[:family] == 'ubuntu' and os[:release] == '14.04' then
    path = "/etc/php/5.6/cli/php.ini"

elsif cfg['php_version'] == '5.6' and os[:family] == 'debian' and os[:release] >= '9' then
        path = "/etc/php/5.6/cli/php.ini"
elsif cfg['php_version'] == '7.0' and (os[:family] == 'debian'  or os[:family] == 'ubuntu') then
    path = "/etc/php/7.0/cli/php.ini"
elsif cfg['php_version'] == '7.1' and (os[:family] == 'debian'  or os[:family] == 'ubuntu') then
    path = "/etc/php/7.1/cli/php.ini"
elsif os[:family] == 'debian' or os[:family] == 'ubuntu' then
    path = '/etc/php5/cli/php.ini'
else
    path = '/etc/php-cli.ini'
end

describe file("#{path}") do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 444 }
    [
        'opcache.enabled = 1',
        'opcache.enable_cli = 0',
        'post_max_size = 8M',
        'memory_limit = 128M',
        'display_errors = Off',
        'apc.enable_cli = 0',
        'apc.enabled = 0',
        'apc.shm_size = 64M',
        'allow_url_fopen = Off',
        'allow_url_include = Off'

    ].each do | line |
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
