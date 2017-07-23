class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :prepare_sidebar_counts

  def prepare_sidebar_counts
  	@sidebar_counts = Hash.new

  	@sidebar_counts[:proposed]  = Lab.where(status:  Lab::PROPOSED).count
    @sidebar_counts[:started]   = Lab.where(status:  Lab::STARTED).count
    @sidebar_counts[:completed] = Lab.where(status:  Lab::COMPLETED).count
    @sidebar_counts[:blocked]   = Lab.where(status:  Lab::BLOCKED).count
    @sidebar_counts[:abandoned] = Lab.where(status:  Lab::ABANDONED).count
    @sidebar_counts[:me]        = Lab.where(user_id: current_user.id).count if user_signed_in?
  end

  def prepare_suggestion_sidebar
    @suggestion_sidebar_mine = Suggestion.where(creator: current_user).count if user_signed_in?

    @suggestion_states_sidebar = SuggestionState.all
  end

  def me?
    me?(@user)
  end

  def me?(user)
    user_signed_in? and user and current_user == user
  end

  def must_be_founder
    if @lab.user_id != current_user.id
      flash[:warning] = 'You do not have access to do that.'
      redirect_to @lab
    end
  end

  def must_be_team_member
    if not @lab.is_team_member?(current_user)
      if @lab.user.id != current_user.id
        flash[:warning] = 'You do not have access to do that.'
        redirect_to @lab
      end
    end
  end

  def must_be_suggestion_team_member
    unless @suggestion.can_modify(current_user)
      flash[:warning] = 'You do not have access to do that.'
      redirect_to suggestions_path
    end
  end

  def must_be_admin
    unless current_user.admin
      flash[:warning] = 'You do not have access to do that.'
      redirect_to root_url
    end
  end
end
