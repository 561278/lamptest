require 'spec_helper'

describe package('redis-server'), :if => os[:family] == 'debian' do
  it { should be_installed }
end

describe service('redis-servr'), :if => os[:family] == 'debian' do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end

describe command('echo "KEY" |redis-cli') do
    its(:stdout) { should match /KEY.*/ }
end
