require 'spec_helper'

describe Suggestion do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @suggestion = FactoryGirl.create(:suggestion, creator: @user)
  end
  subject { @suggestion }

  # Check attributes.
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :creator }
  it { is_expected.to respond_to :team_member }
  it { is_expected.to respond_to :status_id }
  it { is_expected.to respond_to :completion_date }
  it { is_expected.to respond_to :notes }
  
  describe 'when title is not present' do
    before(:each) { @suggestion.title = nil }

    it { is_expected.not_to be_valid }
  end
  
  describe 'when description is not present' do
    before(:each) { @suggestion.description = nil }

    it { is_expected.not_to be_valid }
  end
  
  describe 'when creator is not present' do
    before(:each) { @suggestion.creator = nil }

    it { is_expected.not_to be_valid }
  end
end
