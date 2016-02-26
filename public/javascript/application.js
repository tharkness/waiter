$(document).ready(function() {
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  // Modal stuff, can probably refactor
  $( ".modal-button" ).click(function() {
    $( ".modal" ).toggleClass( "is-active" );
  });
  $( ".modal-background" ).click(function() {
    $( ".modal" ).toggleClass( "is-active" );
  });
  $( ".modal-close" ).click(function() {
    $( ".modal" ).toggleClass( "is-active" );
  });
});
