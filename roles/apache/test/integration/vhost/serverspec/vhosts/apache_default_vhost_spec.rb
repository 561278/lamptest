require 'serverspec'
set :backend, :exec

def isApache24?()
  if (os[:family] == 'debian' && ( os[:release] =~ /8\..*/ || os[:release] =~ /9\..*/ ) ) then
    return true
  elsif (os[:family] == 'ubuntu') then
    return true
  elsif (os[:family] == 'redhat' && os[:release] =~ /7\..*/) then
    return true
  end
  return false
end


  default_site_available_file_name = '000-default.conf'
  default_site_enabled_file_name = '000-default.conf'
  default_ssl_site_available_file_name = 'default-ssl.conf'
  default_ssl_site_enabled_file_name = 'default-ssl.conf'
  default_content = [
    '<VirtualHost *:80>',
    '#ServerName www.example.com',
    'ServerAdmin webmaster@localhost',
    'DocumentRoot /var/www/html',
    'ErrorLog ${APACHE_LOG_DIR}/error.log',
    'CustomLog ${APACHE_LOG_DIR}/access.log combined'
  ]
  ssl_content = [
    '<VirtualHost _default_:443>',
    'ServerAdmin webmaster@localhost',
    'DocumentRoot /var/www/html',
    'ErrorLog ${APACHE_LOG_DIR}/error.log',
    'CustomLog ${APACHE_LOG_DIR}/access.log combined',
    'SSLEngine on',
    'SSLCertificateFile	/etc/ssl/certs/ssl-cert-snakeoil.pem',
    'SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key',
    'SSLOptions +StdEnvVars',
    'BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown',
  ]


describe file('/var/www/html/index.html'), :if => isApache24?() do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end

describe file("/etc/apache2/sites-available/default")  do
  it { should_not exist }
end
describe file("/etc/apache2/sites-available/default-ssl")  do
  it { should_not exist }
end
describe file("/etc/apache2/sites-enabled/000-default")  do
  it { should_not exist }
end
describe file("/var/www/index.html")  do
  it { should_not exist }
end
