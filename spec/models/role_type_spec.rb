require 'spec_helper'

describe RoleType do
  before(:each) { @role_type = FactoryGirl.create(:role_type) }
  subject { @role_type }

  it { is_expected.to respond_to :name }
end