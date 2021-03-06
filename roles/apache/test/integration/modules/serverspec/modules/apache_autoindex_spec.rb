require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/autoindex.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/autoindex.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/autoindex.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/autoindex.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/autoindex.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/autoindex.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'IndexOptions FancyIndexing VersionSort HTMLTable NameWidth=* DescriptionWidth=* Charset=UTF-8',
      'AddIconByEncoding (CMP,/icons/compressed.gif) x-compress x-gzip x-bzip2',
      'AddIconByType (TXT,/icons/text.gif) text/*',
      'AddIconByType (IMG,/icons/image2.gif) image/*',
      'AddIconByType (SND,/icons/sound2.gif) audio/*',
      'AddIconByType (VID,/icons/movie.gif) video/*',
      'AddIcon /icons/binary.gif .bin .exe',
      'AddIcon /icons/binhex.gif .hqx',
      'AddIcon /icons/tar.gif .tar',
      'AddIcon /icons/world2.gif .wrl .wrl.gz .vrml .vrm .iv',
      'AddIcon /icons/compressed.gif .Z .z .tgz .gz .zip',
      'AddIcon /icons/a.gif .ps .ai .eps',
      'AddIcon /icons/layout.gif .html .shtml .htm .pdf',
      'AddIcon /icons/text.gif .txt',
      'AddIcon /icons/c.gif .c',
      'AddIcon /icons/p.gif .pl .py',
      'AddIcon /icons/f.gif .for',
      'AddIcon /icons/dvi.gif .dvi',
      'AddIcon /icons/uuencoded.gif .uu',
      'AddIcon /icons/script.gif .conf .sh .shar .csh .ksh .tcl',
      'AddIcon /icons/tex.gif .tex',
      'AddIcon /icons/bomb.gif /core',
      'AddIcon (SND,/icons/sound2.gif) .ogg',
      'AddIcon (VID,/icons/movie.gif) .ogm',
      'AddIcon /icons/back.gif ..',
      'AddIcon /icons/hand.right.gif README',
      'AddIcon /icons/folder.gif ^^DIRECTORY^^',
      'AddIcon /icons/blank.gif ^^BLANKICON^^',
      'AddIcon /icons/odf6odt-20x22.png .odt',
      'AddIcon /icons/odf6ods-20x22.png .ods',
      'AddIcon /icons/odf6odp-20x22.png .odp',
      'AddIcon /icons/odf6odg-20x22.png .odg',
      'AddIcon /icons/odf6odc-20x22.png .odc',
      'AddIcon /icons/odf6odf-20x22.png .odf',
      'AddIcon /icons/odf6odb-20x22.png .odb',
      'AddIcon /icons/odf6odi-20x22.png .odi',
      'AddIcon /icons/odf6odm-20x22.png .odm',
      'AddIcon /icons/odf6ott-20x22.png .ott',
      'AddIcon /icons/odf6ots-20x22.png .ots',
      'AddIcon /icons/odf6otp-20x22.png .otp',
      'AddIcon /icons/odf6otg-20x22.png .otg',
      'AddIcon /icons/odf6otc-20x22.png .otc',
      'AddIcon /icons/odf6otf-20x22.png .otf',
      'AddIcon /icons/odf6oti-20x22.png .oti',
      'AddIcon /icons/odf6oth-20x22.png .oth',
      'DefaultIcon /icons/unknown.gif',
      'ReadmeName README.html',
      'HeaderName HEADER.html',
      'IndexIgnore .??* *~ *# HEADER* README* RCS CVS *,v *,t',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
