require 'spec_helper'

describe SuggestionVotesController do
  login_user
  before(:each) { @suggestion = FactoryGirl.create(:suggestion, creator: @user) }

  describe "GET 'vote'" do        
    describe "when not voted for already" do
      it "redirects to all suggestions" do
        get :vote, {id: @suggestion.to_param}
        response.should redirect_to suggestions_path
      end

      it "adds a new vote" do
        expect {
          get :vote, {id: @suggestion.to_param}
        }.to change(SuggestionVote, :count).by(1)
      end

      it "adds a flash notice notifying the user about their vote" do
        get :vote, {id: @suggestion.to_param}
        flash[:notice].should =~ /Voted for/i
      end
    end

    describe "when already voted for" do
      before(:each) { FactoryGirl.create(:suggestion_vote, suggestion: @suggestion, user: @user) }

      it "redirects to all suggestions" do
        get :vote, {id: @suggestion.to_param}
        response.should redirect_to suggestions_path
      end

      it "adds a flash notice notifying the user about their vote" do
        get :vote, {id: @suggestion.to_param}
        flash[:alert].should =~ /Problem: /i
      end
    end
  end

  describe "GET 'unvote'" do
    before(:each) { FactoryGirl.create(:suggestion_vote, suggestion: @suggestion, user: @user) }

    it "redirects to all suggestions" do
      delete :unvote, {id: @suggestion.id}
      response.should redirect_to suggestions_path
    end
    it "removes a vote" do
      expect {
        delete :unvote, {id: @suggestion.id}
      }.to change(SuggestionVote, :count).by(-1)
    end
  end

end
