require 'spec_helper'

describe RoleType do
  before(:each) { @role_type = FactoryBot.create(:role_type) }
  subject { @role_type }

  it { is_expected.to respond_to :name }
end