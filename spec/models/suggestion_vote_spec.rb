require 'spec_helper'

describe SuggestionVote do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @suggestion = FactoryGirl.create(:suggestion, creator: @user)
    @suggestion_vote = FactoryGirl.create(:suggestion_vote, suggestion: @suggestion, user: @user)
  end

  it { is_expected.to respond_to :suggestion }
  it { is_expected.to respond_to :user }

end
