require 'serverspec'
set :backend, :exec

if (os[:family] == 'debian' && ( os[:release] =~ /7\..*/ || os[:release] =~ /8\..*/ ) ) then
    describe file('/etc/apache2/mods-enabled/fastcgi.load') do
        it { should be_symlink }
        it { should be_linked_to '../mods-available/fastcgi.load' }
        it { should be_mode 777 }
        it { should be_owned_by 'root' }
    end
    describe file('/etc/apache2/mods-available/fastcgi.load') do
        it { should be_file }
        it { should be_mode 644 }
        it { should be_owned_by 'root' }
    end

    describe file('/etc/apache2/mods-enabled/fastcgi.conf') do
        it { should be_symlink }
        it { should be_linked_to '../mods-available/fastcgi.conf' }
        it { should be_mode 777 }
        it { should be_owned_by 'root' }
    end
    describe file('/etc/apache2/mods-available/fastcgi.conf') do
        it { should be_file }
        it { should be_mode 444 }
        it { should be_owned_by 'root' }
        [
          '<IfModule mod_fastcgi.c>',
          '<FilesMatch ".+(\.fcgi)$">',
          'SetHandler fastcgi-script',
          'FastCgiIpcDir "/var/lib/apache2/fastcgi"',
        ].each do |line|
            its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
        end
    end
end
