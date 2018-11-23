require 'serverspec'
set :backend, :exec

describe file('/etc/apache2/mods-enabled/geoip.load') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/geoip.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/geoip.load') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/geoip.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/geoip.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/geoip.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'GeoIPEnable On',
      'GeoIPOutput All',

    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'GeoIPDBFile ',
      'GeoIPScanProxyHeaders ',
      '#GeoIPScanProxyHeaderField ',
      'GeoIPUseLastXForwardedForIP ',
      'GeoIPEnableUTF8 ',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end