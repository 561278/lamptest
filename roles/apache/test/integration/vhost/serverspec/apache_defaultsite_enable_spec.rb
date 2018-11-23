require 'serverspec'
set :backend, :exec

describe port(80) do
    it { should be_listening }
end
describe port(8080) do
    it { should be_listening }
end
describe port(443) do
    it { should be_listening }
end
describe port(8443) do
    it { should be_listening }
end
