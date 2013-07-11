require 'spec_helper'

describe Authentication do
  before do
    @provider = Fabricate(:authentication)
  end

  subject { @provider }

  it { should be_valid }
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }

  it { should belong_to(:user) }
end
