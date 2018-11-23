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
      'ModPagespeedInheritVHostConfig on',
      'AddOutputFilterByType MOD_PAGESPEED_OUTPUT_FILTER text/html',
      'ModPagespeedFileCachePath "/var/cache/mod_pagespeed"',
      'ModPagespeedLogDir "/var/log/pagespeed"',
      'ModPagespeedRewriteLevel CoreFilters',
      'ModPagespeedRewriteDeadlinePerFlushMs 10',
      'ModPagespeedFileCacheSizeKb          102400',
      'ModPagespeedFileCacheCleanIntervalMs 3600000',
      'ModPagespeedLRUCacheKbPerProcess     1024',
      'ModPagespeedLRUCacheByteLimit        16384',
      'ModPagespeedCssFlattenMaxBytes       2048',
      'ModPagespeedCssInlineMaxBytes        2048',
      'ModPagespeedCssImageInlineMaxBytes   2048',
      'ModPagespeedImageInlineMaxBytes      2048',
      'ModPagespeedJsInlineMaxBytes         2048',
      'ModPagespeedCssOutlineMinBytes       3000',
      'ModPagespeedJsOutlineMinBytes        3000',
      'ModPagespeedFileCacheInodeLimit 500000',
      'ModPagespeedImageMaxRewritesAtOnce 8',
      'ModPagespeedNumRewriteThreads 4',
      'ModPagespeedNumExpensiveRewriteThreads 4',
      'ModPagespeedStatistics on',
      '<Location /mod_pagespeed_statistics>',
      'SetHandler mod_pagespeed_statistics',
      'ModPagespeedStatisticsLogging on',
      '<Location /pagespeed_console>',
      'SetHandler pagespeed_console',
      'ModPagespeedMessageBufferSize 100000',
      '<Location /mod_pagespeed_message>',
      'SetHandler mod_pagespeed_message',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
    [
      'AddOutputFilterByType MOD_PAGESPEED_OUTPUT_FILTER application/xhtml+xml',
      'ModPagespeedMemcachedServers',
      'ModPagespeedDisableFilters',
      'ModPagespeedEnableFilters',
      'ModPagespeedForbidFilters',
      'ModPagespeedDomain ',
    ].each do |line|
        its(:content) { should_not match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/pagespeed.conf'), :if => isApache24?() do
    [
      'Require ip 127.0.0.1 ::1',
      'Require ip 127.0.0.1 ::1',
      'Require ip 127.0.0.1 ::1',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
