require 'spec_helper'

describe Suggestion do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @suggestion = FactoryGirl.create(:suggestion, creator: @user)
  end
  subject { @suggestion }

  # Check attributes.
  it { should respond_to :title }
  it { should respond_to :description }
  it { should respond_to :creator }
  it { should respond_to :team_member }
  it { should respond_to :status_id }
  it { should respond_to :completion_date }
  it { should respond_to :notes }
  
  describe 'when title is not present' do
    before(:each) { @suggestion.title = nil }

    it { should_not be_valid }
  end
  
  describe 'when description is not present' do
    before(:each) { @suggestion.description = nil }

    it { should_not be_valid }
  end
  
  describe 'when creator is not present' do
    before(:each) { @suggestion.creator = nil }

    it { should_not be_valid }
  end
end
