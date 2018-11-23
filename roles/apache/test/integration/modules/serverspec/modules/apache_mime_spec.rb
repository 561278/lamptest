require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/mime.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/mime.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/mime.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/mime.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/mime.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/mime.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_mime.c>',
      'TypesConfig /etc/mime.types',
      'AddType application/x-compress .Z',
      'AddType application/x-gzip .gz .tgz',
      'AddType application/x-bzip2 .bz2',
      'AddLanguage ca .ca',
      'AddLanguage cs .cz .cs',
      'AddLanguage da .dk',
      'AddLanguage de .de',
      'AddLanguage el .el',
      'AddLanguage en .en',
      'AddLanguage eo .eo',
      'AddLanguage es .es',
      'AddLanguage et .et',
      'AddLanguage fr .fr',
      'AddLanguage he .he',
      'AddLanguage hr .hr',
      'AddLanguage it .it',
      'AddLanguage ja .ja',
      'AddLanguage ko .ko',
      'AddLanguage ltz .ltz',
      'AddLanguage nl .nl',
      'AddLanguage nn .nn',
      'AddLanguage no .no',
      'AddLanguage pl .po',
      'AddLanguage pt .pt',
      'AddLanguage pt-BR .pt-br',
      'AddLanguage ru .ru',
      'AddLanguage sv .sv',
      'AddLanguage zh-CN .zh-cn',
      'AddLanguage zh-TW .zh-tw',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
