require 'spec_helper'

describe TeamRole do
  before(:each) { @team_role = FactoryBot.create(:team_role) }
  subject { @team_role }

  it { is_expected.to respond_to :lab }
  it { is_expected.to respond_to :role_type }
  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :comment }

  describe 'when lab is not present' do
    before(:each) { @team_role.lab = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when role_type is not present' do
    before(:each) { @team_role.role_type = nil }

    it { is_expected.not_to be_valid }
  end
end
