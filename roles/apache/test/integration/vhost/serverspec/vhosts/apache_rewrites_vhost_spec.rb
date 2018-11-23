require 'serverspec'
set :backend, :exec

describe file('/var/www/rewrites') do
  it { should be_directory }
end

describe file('/etc/apache2/sites-enabled/rewrite1.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/rewrite1.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/rewrite1.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'RewriteEngine On',
    '#Lynx or Mozilla v1/2',
    '#Internet Explorer',
    '#Rewrite to lower case',
    'RewriteCond %{HTTP_USER_AGENT} ^Lynx/ [OR]',
    'RewriteCond %{HTTP_USER_AGENT} ^Mozilla/[12]',
    'RewriteCond %{HTTP_USER_AGENT} ^MSIE',
    'RewriteCond %{REQUEST_URI} [A-Z]',
    'RewriteMap lc int:tolower',
    'RewriteRule ^index\.html$ welcome.html',
    'RewriteRule ^index\.html$ /index.IE.html [L]',
    'RewriteRule (.*) ${lc:$1} [R=301,L]',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
end

describe file('/etc/apache2/sites-enabled/rewrite2.conf')  do
  it { should be_symlink }
  it { should be_linked_to '../sites-available/rewrite2.conf' }
  it { should be_owned_by 'root' }
  it { should be_mode 777 }
end
describe file('/etc/apache2/sites-available/rewrite2.conf')  do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 444 }
  [
    'RewriteEngine On',
    'RewriteRule ^index\.asp$ index.html',
    'RewriteRule ^index\.html$ index.php',
    'RewriteRule ^index\.cgi$ index.php',
    'RewriteOptions Inherit',
  ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
  end
  [
    'RewriteCond ',
    'RewriteMap ',
  ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
  end
end
