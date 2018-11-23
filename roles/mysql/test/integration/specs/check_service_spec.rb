require 'serverspec'
set :backend, :exec

describe service('mysql') do
  it { should be_enabled }
end

describe port(3306) do
  it { should be_listening }
end
