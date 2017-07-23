class SuggestionVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_suggestion
  
  def vote
     @suggestion_vote = SuggestionVote.new(suggestion: @suggestion, user: current_user)
     respond_to do |format|
      if @suggestion_vote.save
        format.html { redirect_to suggestions_path, notice: "Voted for: <em>#{@suggestion.title}</em>".html_safe }
        format.json { render action: 'show', status: :created, location: suggestions_path }
      else
        format.html { redirect_to suggestions_path, alert: "Problem: #{@suggestion_vote.errors.full_messages}" }
        format.json { render json: @suggestion_vote.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def unvote
    @suggestion_votes = SuggestionVote.where('suggestion_id = ? and user_id = ?', @suggestion.id, current_user.id)
    @suggestion_votes.first.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_path }
      format.json { head :no_content }
    end
  end
  
  private
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

end
