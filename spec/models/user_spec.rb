require 'spec_helper'

describe User do
  before(:each) { @user = FactoryGirl.create(:user) }
  subject { @user }

  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :admin }
  it { should respond_to :suggestion_team_member }
  it { should respond_to :supports }
  it { should respond_to :meeting_notice }

  # named scopes
  it 'should respond to all_team_members' do
    expect(User).to respond_to :all_team_members
  end

  describe 'admin' do
    it 'should be false by default' do
      expect(@user.admin).to be false
    end
  end

  describe 'meeting_notice' do
    it 'should be false by default' do
      expect(@user.meeting_notice).to be false
    end
  end
end
