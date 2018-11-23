require 'serverspec'
set :backend, :exec

require 'yaml'
cfg = YAML.load_file(File.dirname(File.expand_path(__FILE__))  + '/properties.yml')

cfg['mysql_packages'].each do | pkg |

    describe package(pkg) do
        it { should be_installed }
    end

end


