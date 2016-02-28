
function decrement_two_seat_wait() {
  $.get( "/restaurants/decrement_two_seat_wait", function(data) {
    $('#two_seat_wait').html(data.two_seat_wait);
  }); 
};

function increment_two_seat_wait() {
  $.get("/restaurants/increment_two_seat_wait", function(data) {
    $('#two_seat_wait').html(data.two_seat_wait);
  });
};

function reset_two_seat_wait() {
  $.get("/restaurants/reset_two_seat_wait", function(data) {
    $('#two_seat_wait').html(data.two_seat_wait);
  });
};

function decrement_four_seat_wait() {
  $.get( "/restaurants/decrement_four_seat_wait", function(data) {
    $('#four_seat_wait').html(data.four_seat_wait);
  }); 
};

function increment_four_seat_wait() {
  $.get("/restaurants/increment_four_seat_wait", function(data) {
    $('#four_seat_wait').html(data.four_seat_wait);
  });
};

function reset_four_seat_wait() {
  $.get("/restaurants/reset_four_seat_wait", function(data) {
    $('#four_seat_wait').html(data.four_seat_wait);
  });
};

function decrement_large_table_wait() {
  $.get("/restaurants/decrement_large_table_wait", function(data) {
    $('#large_table_wait').html(data.large_table_wait);
  });
};

function increment_large_table_wait() {
  $.get("/restaurants/increment_large_table_wait", function(data) {
    $('#large_table_wait').html(data.large_table_wait);
  });
};

function reset_large_table_wait() {
  $.get("/restaurants/reset_large_table_wait", function(data) {
    $('#large_table_wait').html(data.large_table_wait);
  });
};

function set_four_seat_wait() {
  $.get("/restaurants/set_four_seat_wait", function(data) {
    $('#four_seat_wait').html(data.four_seat_wait);
  });
};



