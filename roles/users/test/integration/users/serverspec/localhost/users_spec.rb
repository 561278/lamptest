require 'spec_helper'

describe 'User resource type' do
  describe user('helldorado') do
    it { should exist }
    it { should belong_to_group 'helldorado' }

    it { should have_home_directory '/home/hell' }

    it { should have_login_shell '/bin/bash' }
  end

  describe group('helldorado') do
      it { should exist }
  end
end


describe "User and database on mysql exist" do
  describe "'sabrewulf' and 'raiden' mysql user is created for localhost" do
    describe command("sudo echo \"SELECT User, Host FROM mysql.user\" | mysql") do
      its(:stdout) { should match /sabrewulf\tlocalhost/ }
      its(:stdout) { should match /raiden\tlocalhost/ }
    end
  end

  describe "'spinal' database exists" do
    describe command("sudo echo \"SHOW DATABASES LIKE 'spinal'\" | mysql") do
      its(:stdout) { should match /spinal/ }
    end
  end
end

describe "User and database on postgresql exist" do
  describe "'glacius' and 'jago' postgresql user is created" do
    describe command('sudo -u postgres -s psql postgres -tAc "\du"') do
      its(:stdout) { should match /glacius/ }
      its(:stdout) { should match /jago/ }
    end
  end

  describe "'db_glacius' and 'db_orchid' postgresql database exist" do
    describe command('sudo -u postgres -s psql postgres -tAc "\l"') do
      its(:stdout) { should match /db_glacius/ }
      its(:stdout) { should match /db_orchid/ }
    end
  end
end


