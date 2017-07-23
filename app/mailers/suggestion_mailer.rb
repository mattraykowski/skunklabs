class SuggestionMailer < ActionMailer::Base
  default from: '"Skunk Labs" <no-reply@childrensmn.org>'

  def suggestion_created(suggestion)
    @suggestion = suggestion

    mail(to: User.all_team_members.pluck(:email), reply_to: @suggestion.creator.email, subject: 'New Suggestion Submitted to Skunk Works')
  end

  def suggestion_destroyed(suggestion, destroyer)
    @suggestion = suggestion
    @destroyer = destroyer


    # Get all of the suggestion team members and the creator.
    targets = User.all_team_members.pluck(:email)
    targets.push @suggestion.creator.email

    mail(to: targets, reply_to: @destroyer[:email], subject: 'Skunk Works Suggestion Deleted')
  end
end
