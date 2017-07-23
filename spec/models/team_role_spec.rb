require 'spec_helper'

describe TeamRole do
  before(:each) { @team_role = FactoryGirl.create(:team_role) }
  subject { @team_role }

  it { should respond_to :lab }
  it { should respond_to :role_type }
  it { should respond_to :user }
  it { should respond_to :comment }

  describe 'when lab is not present' do
    before(:each) { @team_role.lab = nil }

    it { should_not be_valid }
  end

  describe 'when role_type is not present' do
    before(:each) { @team_role.role_type = nil }

    it { should_not be_valid }
  end
end