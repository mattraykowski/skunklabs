require 'spec_helper'

describe RoleType do
  before(:each) { @role_type = FactoryGirl.create(:role_type) }
  subject { @role_type }

  it { should respond_to :name }
end