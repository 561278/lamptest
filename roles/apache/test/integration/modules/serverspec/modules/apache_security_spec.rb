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

describe file('/etc/apache2/mods-enabled/security.conf') do
    it { should be_symlink }
    it { should be_linked_to '../mods-available/security.conf' }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
end
describe file('/etc/apache2/mods-available/security.conf') do
    it { should be_file }
    it { should be_mode 444 }
    it { should be_owned_by 'root' }
    [
      '<IfModule mod_security2.c>',
      'SecRuleEngine  On',
      'SecRequestBodyAccess On',
      'SecRule REQUEST_HEADERS:Content-Type "text/xml"',
      '"id:\'200000\',phase:1,t:none,t:lowercase,pass,nolog,ctl:requestBodyProcessor=XML"',
      'SecRequestBodyLimit 13107200',
      'SecRequestBodyNoFilesLimit 131072',
      'SecRequestBodyInMemoryLimit 131072',
      'SecRequestBodyLimitAction Reject',
      'SecRule REQBODY_ERROR "!@eq 0"',
      '"id:\'200001\', phase:2,t:none,log,deny,status:400,msg:\'Failed to parse request body.\',logdata:\'%{reqbody_error_msg}\',severity:2"',
      'SecRule MULTIPART_STRICT_ERROR "!@eq 0"',
      '"id:\'200002\',phase:2,t:none,log,deny,status:44,msg:\'Multipart request body failed strict validation:',
      'PE %{REQBODY_PROCESSOR_ERROR},',
      'BQ %{MULTIPART_BOUNDARY_QUOTED},',
      'BW %{MULTIPART_BOUNDARY_WHITESPACE},',
      'DB %{MULTIPART_DATA_BEFORE},',
      'DA %{MULTIPART_DATA_AFTER},',
      'HF %{MULTIPART_HEADER_FOLDING},',
      'LF %{MULTIPART_LF_LINE},',
      'SM %{MULTIPART_MISSING_SEMICOLON},',
      'IQ %{MULTIPART_INVALID_QUOTING},',
      'IP %{MULTIPART_INVALID_PART},',
      'IH %{MULTIPART_INVALID_HEADER_FOLDING},',
      'FL %{MULTIPART_FILE_LIMIT_EXCEEDED}\'"',
      'SecRule &REQUEST_HEADERS:Proxy "@gt 0" "id:1000005,log,deny,msg:\'httpoxy denied\'"',
      'SecRule MULTIPART_UNMATCHED_BOUNDARY "!@eq 0"',
      '"id:\'200003\',phase:2,t:none,log,deny,status:44,msg:\'Multipart parser detected a possible unmatched boundary.\'"',
      'SecPcreMatchLimit 1500',
      'SecPcreMatchLimitRecursion 1500',
      'SecRule TX:/^MSC_/ "!@streq 0"',
      '"id:\'200004\',phase:2,t:none,deny,msg:\'ModSecurity internal error flagged: %{MATCHED_VAR_NAME}\'"',
      'SecResponseBodyAccess Off',
      'SecResponseBodyMimeType text/plain text/html text/xml',
      'SecResponseBodyLimit 524288',
      'SecResponseBodyLimitAction ProcessPartial',
      'SecDebugLogLevel 0',
      'SecAuditEngine RelevantOnly',
      'SecAuditLogRelevantStatus "^(?:5|4(?!04))"',
      'SecAuditLogParts ABIJDEFHZ',
      'SecAuditLogType Serial',
      'SecArgumentSeparator &',
      'SecCookieFormat 0',
      'SecUploadKeepFiles Off',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/security.conf'), :if => os[:family] == 'debian' || os[:family] == 'ubuntu' do
    [
      'SecDebugLog /var/log/apache2/modsec_debug.log',
      'SecAuditLog /var/log/apache2/modsec_audit.log',
      'SecTmpDir /var/cache/modsecurity',
      'SecDataDir /var/cache/modsecurity',
      'SecUploadDir /var/cache/modsecurity',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/security.conf'), :if => os[:family] == 'redhat' do
    [
      'SecDebugLog /var/log/httpd/modsec_debug.log',
      'SecAuditLog /var/log/httpd/modsec_audit.log',
      'SecTmpDir /var/lib/mod_security',
      'SecDataDir /var/lib/mod_security',
      'SecUploadDir /var/lib/mod_security',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/security.conf'), :if => ! isApache24?() do
    [
      'Include /etc/modsecurity/*.conf',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
describe file('/etc/apache2/mods-available/security.conf'), :if => isApache24?() do
    [
      'IncludeOptional /etc/modsecurity/*.conf',
    ].each do |line|
        its(:content) { should match /^\s*#{Regexp.escape(line)}/ }
    end
end
