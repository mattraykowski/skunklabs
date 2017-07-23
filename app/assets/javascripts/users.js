$(function() {
  // Watch the admin checkbox/switch.
  $('input[name="admin-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
    var userid = $('input[name="user_id"]').val();
    
    $.ajax({
      url: '/admin/users/' + userid + '/admin',
      type: 'PUT',
      data: { 'admin': state }
    });
  });
  
  // Watch the team checkbox/switch.
  $('input[name="team-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
    var userid = $('input[name="user_id"]').val();
    
    $.ajax({
      url: '/admin/users/' + userid + '/team',
      type: 'PUT',
      data: { 'team': state }
    });
  }); 

  // Watch the meeting notices checkbox/switch.
  $('input[name="notices-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
    var userid = $('input[name="user_id"]').val();
    
    $.ajax({
      url: '/admin/users/' + userid + '/notices',
      type: 'PUT',
      data: { 'notices': state }
    });
  }); 
});

