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

describe file('/etc/apache2/mods-enabled/pagespeed.load'), :if => isApache24?() do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/pagespeed.load' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/pagespeed.load'), :if => isApache24?() do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
end

describe file('/etc/apache2/mods-enabled/pagespeed.conf'), :if => isApache24?() do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/pagespeed.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/pagespeed.conf'), :if => isApache24?() do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      'ModPagespeed on',
      'ModPagespeedInheritVHostConfig off',
      'AddOutputFilterByType MOD_PAGESPEED_OUTPUT_FILTER text/html',
      'AddOutputFilterByType MOD_PAGESPEED_OUTPUT_FILTER application/xhtml+xml',
      'ModPagespeedFileCachePath "/opt/certs"',
      'ModPagespeedLogDir "/opt"',
      'ModPagespeedRewriteLevel PassThrough',
      'ModPagespeedRewriteDeadlinePerFlushMs 20',
      'ModPagespeedFileCacheSizeKb          204800',
      'ModPagespeedFileCacheCleanIntervalMs 3600',
      'ModPagespeedLRUCacheKbPerProcess     2048',
      'ModPagespeedLRUCacheByteLimit        4096',
      'ModPagespeedCssFlattenMaxBytes       1024',
      'ModPagespeedCssInlineMaxBytes        512',
      'ModPagespeedCssImageInlineMaxBytes   4096',
      'ModPagespeedImageInlineMaxBytes      4096',
      'ModPagespeedJsInlineMaxBytes         1024',
      'ModPagespeedCssOutlineMinBytes       4000',
      'ModPagespeedJsOutlineMinBytes        4010',
      'ModPagespeedFileCacheInodeLimit 700000',
      'ModPagespeedImageMaxRewritesAtOnce 7',
      'ModPagespeedNumRewriteThreads 5',
      'ModPagespeedNumExpensiveRewriteThreads 3',
      'ModPagespeedStatistics off',
      '<Location /mod_pagespeed_statistics>',
      'SetHandler mod_pagespeed_statistics',
      'ModPagespeedStatisticsLogging off',
      '<Location /pagespeed_console>',
      'SetHandler pagespeed_console',
      'ModPagespeedMessageBufferSize 4000',
      '<Location /mod_pagespeed_message>',
      'SetHandler mod_pagespeed_message',
      'ModPagespeedDomain toto.foo',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'ModPagespeedMemcachedServers',
      'ModPagespeedDisableFilters',
      'ModPagespeedEnableFilters',
      'ModPagespeedForbidFilters',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/pagespeed.conf'), :if => isApache24?() do
    [
      'Require ip 127.0.0.1 ::1 10.0.1.1 10.0.1.2',
      'Require ip 127.0.0.1 ::1 10.0.2.1 10.0.2.2',
      'Require ip 127.0.0.1 ::1 10.0.3.1 10.0.3.2',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
