require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')


describe command('php -m') do


    if cfg['php_version'] == '5.3' or cfg['php_version'] == '5.4' then

        [
            'Zend OPcache',

        ].each do | line |
            its(:stdout) { should_not match /^\s*#{Regexp.escape(line)}/ }
        end

    else

        [
            'Zend OPcache',

        ].each do | line |
            its(:stdout) { should match /^\s*#{Regexp.escape(line)}/ }
        end

    end

    [
       'apc',

    ].each do | line |
        its(:stdout) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end

end

