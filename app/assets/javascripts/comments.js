$(document).ready(function() {
   // Turn the slider on the comment progress box.
  $("#updatePercent").slider({});

  $('#comment_is_update').on('click', function () {
    $("#lab-progress-group").toggle(this.checked);
  });

  $('#comment_is_update').on('click', function(event) {
  	console.log(event.currentTarget.checked);
  });
})
