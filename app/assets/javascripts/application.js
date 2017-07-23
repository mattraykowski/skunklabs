// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require handlebars/handlebars.runtime
//= require bootstrap/dist/js/bootstrap
//= require bootbox/bootbox
//= require wysihtml5/dist/wysihtml5-0.2.0
//= require bootstrap3-wysihtml5-bower/dist/bootstrap3-wysihtml5.all.min
//= require seiyria-bootstrap-slider/js/bootstrap-slider
//= require bootstrap-switch/dist/js/bootstrap-switch
//= require turbolinks

$(document).ready(function() {
  /**
   * Any anchor or button that has the 'proposeDisclamer' id will generate a bootstrap modal.
   */
  $('.proposeDisclaimer').on('click', function(event) {
  	event.preventDefault();
    var anchor = event.currentTarget;

    $.get( '/partials/bbt-propose-disclaimer.html', function(data) {
        bootbox.confirm(data, function(result) {
          if(result) {
            window.location.href = anchor.href;
          }
        });
      }
    );
  });

  /**
   * This is a generate click handler for help tip modals.
   *
   * Usage: Define the class 'help-tip' on an element and provide the attribute tip-url with
   *        a path directing to an HTML partial defining the content to be presented in the modal.
   *
   *        <a class="help-tip" tip-url="/help/file.html">More Info</a>
   */
  $('.help-tip').on('click', function(event) {
    var element = $(event.currentTarget);
    var tipUrl = element.attr('tip-url');
    console.log(tipUrl);
    $.get( tipUrl, function(data) {
      bootbox.alert(data);
    });
  });

  // Enable wysihtml5 editing for specific text areas.
  $('.bswysiwyg').wysihtml5({'fa': true, 'font-styles': true, 'html': true, 'color': true, 'image': true, 'size': 'xs'});

  $.rails.allowAction = function(link) {
    if (!link.attr('data-confirm')) {
      return true;
    }
    $.rails.showConfirmDialog(link);
    return false;
  };

  $.rails.confirmed = function(link) {
    link.removeAttr('data-confirm');
    return link.trigger('click.rails');
  };

  $.rails.showConfirmDialog = function(link) {
    var message = link.attr('data-confirm');
    bootbox.confirm(message, function(result) {
      if(result) {
        $.rails.confirmed(link);
      }
    });
  };

  $(window).load(function() {
    setTimeout(function() { $('.alert-success').fadeOut(600); }, 2000);
  });

  // Enable all tooltips.
  $("[data-toggle='tooltip']").tooltip();

  // Contain the popover within the body NOT the element it was called in.
  $('.popover-html').popover({ html : true, trigger: 'hover', container: 'body' });
  $(".bootswitch").bootstrapSwitch();
});
