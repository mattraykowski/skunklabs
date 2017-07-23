$(function() {
  // Watch the meeting notices checkbox/switch.
  $('input[name="notices-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
    $.ajax({
      url: '/profile/notices',
      type: 'PUT',
      data: { 'notices': state }
    });
  });
});
