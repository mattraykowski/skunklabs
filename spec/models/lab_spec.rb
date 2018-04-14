require 'spec_helper'

describe Lab do
  before(:each) { @lab = FactoryGirl.create(:lab) }
  subject { @lab }

  # Check attributes.
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :goals }
  it { is_expected.to respond_to :measurements }
  it { is_expected.to respond_to :focus_type }
  it { is_expected.to respond_to :team_roles }
  it { is_expected.to respond_to :status }
  it { is_expected.to respond_to :comments }
  it { is_expected.to respond_to :link_resources }
  it { is_expected.to respond_to :lab_supporters }

  # Check scopes.
  it { is_expected.to respond_to :is_team_member? }
  it { is_expected.to respond_to :is_owner? }
  it { is_expected.to respond_to :overall_progress }
  it { is_expected.to respond_to :lab_watchers }

  describe 'when name is not present' do
    before(:each) { @lab.name = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when goals is not present' do
    before(:each) { @lab.goals = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when measurements is not present' do
    before(:each) { @lab.measurements = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when focus_type is not present' do
    before(:each) { @lab.focus_type = nil }

    it { is_expected.not_to be_valid }
  end

  describe 'when status is invalid' do
    before(:each) { @lab.status = 9999 }
    it { is_expected.not_to be_valid }
  end

  describe 'is_team_member?' do
    describe 'when there are no team members' do
      it 'should be false' do
        expect(@lab.is_team_member?(@lab.user)).to be false
      end
    end

    describe 'when the user matches a team member' do
      it 'should be true' do
        team_role = FactoryGirl.create(:team_role, lab: @lab, user: @lab.user)
        team_role.save


        expect(@lab.is_team_member?(@lab.user)).to be true
      end
    end

    describe 'when the user does not match a team member' do
      it 'should be false' do
        addl_user = FactoryGirl.create(:user, email: 'foobar@test.com', login: 'foobar')
        team_role = FactoryGirl.create(:team_role, lab: @lab, user: addl_user)
        team_role.save

        expect(@lab.is_team_member?(@lab.user)).to be false
      end
    end
  end

  describe 'is_owner?' do
    describe 'when user is not the owner' do
      it 'should be false' do
        addl_user = FactoryGirl.create(:user, email: 'foobar@test.com', login: 'foobar')
        expect(@lab.is_owner?(addl_user)).to be false
      end
    end

    describe 'when other user is nil' do
      it 'should be false' do
        expect(@lab.is_owner?(nil)).to be false
      end
    end

    describe 'when user is the owner' do
      it 'should be true' do
        expect(@lab.is_owner?(@lab.user)).to be true
      end
    end
  end

  describe 'overall_progress' do
    describe 'when there are no comments' do
      it 'should return no progress' do
        expect(Comment.count).to be(0)

        expect(@lab.overall_progress).to be(0)
      end
    end
  end

  describe 'lab_watchers' do
    before(:each) do
      @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
      @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @alt_user)
    end

    it 'should include the lab founder' do
      expect(@lab.lab_watchers.find { |watcher| watcher.id == @lab.user.id }).to_not be_nil
    end

    it 'should include team members based on role' do
      expect(@lab.lab_watchers.find { |watcher| watcher.id == @team_role.user.id }).to_not be_nil
    end

    describe 'when user is a supporter' do
      before(:each) do
        @alt_user2 = FactoryGirl.create(:user, email: 'altuser2@example.com', login: 'altuser2')
        @lab_supporter = FactoryGirl.create(:lab_supporter, lab: @lab, user: @alt_user2)
      end

      it 'should include supporters' do
        expect(@lab.lab_watchers.find { |watcher| watcher.id == @lab_supporter.user.id}).to_not be_nil
      end
    end
  end

  describe 'status transitions' do
    describe 'when status is proposed' do
      before(:each) { @lab.status = Lab::PROPOSED }
      it 'should be valid if trasnitioning to STARTED' do
        expect(@lab.transition_okay?(Lab::STARTED)).to be true
      end

      it 'should be invalid if transitioning to any other status' do
        invalid_statuses = Lab::STATUSES
        invalid_statuses.delete(Lab::STARTED)

        invalid_statuses.keys.each do |invalid_status|
          expect(@lab.transition_okay?(invalid_status)).to be false
        end
      end
    end

    describe 'when status is started' do
      before(:each) { @lab.status = Lab::STARTED }
      it 'should be valid if trasnitioning to COMPLETED, BLOCKED, or ABANDONED' do
        valid_statuses = Lab::STATUSES
        valid_statuses.delete(Lab::STARTED)
        valid_statuses.delete(Lab::PROPOSED)

         valid_statuses.keys.each do |valid_status|
          expect(@lab.transition_okay?(valid_status)).to be true
        end
      end

      it 'should be invalid if transitioning to any other status' do
        invalid_statuses = Lab::STATUSES
        invalid_statuses.delete(Lab::COMPLETED)
        invalid_statuses.delete(Lab::BLOCKED)
        invalid_statuses.delete(Lab::ABANDONED)

        invalid_statuses.keys.each do |invalid_status|
          expect(@lab.transition_okay?(invalid_status)).to be false
        end
      end
    end

    describe 'when status is blocked' do
      before(:each) { @lab.status = Lab::BLOCKED }
      it 'should be valid if trasnitioning to STARTED or ABANDONED' do
        valid_statuses = Lab::STATUSES
        valid_statuses.delete(Lab::BLOCKED)
        valid_statuses.delete(Lab::PROPOSED)
        valid_statuses.delete(Lab::COMPLETED)

         valid_statuses.keys.each do |valid_status|
          expect(@lab.transition_okay?(valid_status)).to be true
        end
      end

      it 'should be invalid if transitioning to any other status' do
        invalid_statuses = Lab::STATUSES
        invalid_statuses.delete(Lab::STARTED)
        invalid_statuses.delete(Lab::ABANDONED)

        invalid_statuses.keys.each do |invalid_status|
          expect(@lab.transition_okay?(invalid_status)).to be false
        end
      end
    end
  end
end
