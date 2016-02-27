$(document).ready(function() {
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  // Modal stuff, can probably refactor
  $( ".modal-button" ).click(function() {
    var target = $(this).data('target');
    $(target).addClass('is-active');
  });

  $('.modal-background, .modal-close').click(function() {
    $(this).parent().removeClass('is-active');
  });
});
