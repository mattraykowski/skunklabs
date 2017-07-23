module ApplicationHelper
  def get_user_popover_name(user, destination='')
    popover_str = "<div class='row'><div class='col-xs-4'>" + 
                  "#{gravatar_image_tag(user.email, alt: user.safe_name).gsub("\"","\'")}" +
                  "</div><div class='col-xs-8'>" +
                  "<strong>Email:</strong> #{user.email}<br/>" + 
                  "<strong>Job:</strong> #{user.job_title}<br/>" +
                  "<strong>Department:</strong> #{user.department}</div>"
                  
    link_to user.safe_name, destination, 
      class: 'popover-html', 
      data: { 
        toggle: 'popover', 
        placement: 'bottom', 
        title: user.safe_name,
        content: popover_str.html_safe }
  end
  
  def get_progress_report(team_roles)
    popover_str = ''
    
    if team_roles.nil?
      popover_str = 'No team roles have been added!<br/>Please add some team roles!<br/>'
    else
      team_roles.each do |role|            
        popover_str += "#{role.user ? role.user.safe_name : '<span class="text-danger">vacant</span>'} (<em>#{role.role_type.name}</em>) <strong>#{role.progress}%</strong><br/>"
      end
    end
    
    
    popover_str
  end
  
  def suggestion_voted_for(suggestion, user)
    return false unless user_signed_in?
    
    vote = suggestion.suggestion_votes.find_by_user_id(user.id)
    if vote.nil?
      return false
    else
      return true
    end
  end
end
