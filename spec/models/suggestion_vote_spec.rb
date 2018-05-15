require 'spec_helper'

describe SuggestionVote do

  before(:each) do
    @user = FactoryBot.create(:user)
    @suggestion = FactoryBot.create(:suggestion, creator: @user)
    @suggestion_vote = FactoryBot.create(:suggestion_vote, suggestion: @suggestion, user: @user)
  end

  it { is_expected.to respond_to :suggestion }
  it { is_expected.to respond_to :user }

end
