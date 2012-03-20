require 'spec_helper'

describe UsersHelper do

  describe '#gravatar_url' do
    let(:user) { User.make :email => 'Bob@test.com' }
    subject { gravatar_url(user) }
    it { should == 'https://gravatar.com/avatar/ebf3a1ca1e3ca553e2bd873b3cd96390' }
  end

end
