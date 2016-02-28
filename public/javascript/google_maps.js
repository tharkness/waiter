getLocation();
var x = document.getElementById("map");


function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition,showError);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";}
}



//Storing longitude and lattitude

function showPosition(position) {

    lat = position.coords.latitude;
    lon = position.coords.longitude;
    document.getElementById('lat').value = lat;
    document.getElementById('lon').value = lon;

    latlon = new google.maps.LatLng(lat, lon)
    mapholder = document.getElementById('map')

    // -----------edit height and width--------------

//    mapholder.style.height='250px';
//    mapholder.style.width='500px';

    var myOptions={
    center:latlon,zoom:14,
    mapTypeId:google.maps.MapTypeId.ROADMAP,
    mapTypeControl:false,
    navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
    }

    var map = new google.maps.Map(document.getElementById("map"),myOptions);
    var marker = new google.maps.Marker({position:latlon,map:map,title:"You are here!"});

    var marker = new google.maps.Marker({
    position: latlon,
    map: map,
    title: 'Hello World!'
  });


    //----------- Making markers --------------------

//     function drop() {
//   for (var i =0; i < markerArray.length; i++) {
//     setTimeout(function() {
//       addMarkerMethod();
//     }, i * 200);
//   }
// }


var markers=[];
var contents = [];
var infowindows = [];



//----------Add markers to the map---------------

for (i = 0; i < 9; i++) {
    a = i * 2 
    markers[i] = new google.maps.Marker({
        position: new google.maps.LatLng(gon.resteraunts[(a)].lat, gon.resteraunts[(a)].lng),
        label: gon.resteraunts[(a - 1)]
    });

    markers[i].index = i; //add index property
    contents[i] = ['<p>',gon.resteraunts[(a - 1)],'</p>'].join("");


    infowindows[i] = new google.maps.InfoWindow({
        content: contents[i],
        maxWidth: 300
    });

    google.maps.event.addListener(markers[i], 'click', function() {
        console.log(this.index); // this will give correct index
        console.log(i); //this will always give 10 for you
        infowindows[this.index].open(map,markers[this.index]);
        map.panTo(markers[this.index].getPosition());
    });  
}

// ----------------------Populates map--------------------------------------------------

for (i = 0; i < 8; i++) {
  markers[i].setMap(map);
}

}





//In case shit hits the fan

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            x.innerHTML = "User denied the request for Geolocation."
            break;
        case error.POSITION_UNAVAILABLE:
            x.innerHTML = "Location information is unavailable."
            break;
        case error.TIMEOUT:
            x.innerHTML = "The request to get user location timed out."
            break;
        case error.UNKNOWN_ERROR:
            x.innerHTML = "An unknown error occurred."
            break;
    }

}

// Grabbing lat and long


// console.log(gon.resteraunts);

// var marker = new google.maps.Marker({
//     var position = new google.maps.LatLng(gon.resteraunts[2].lat, gon.resteraunts[2].lng)
//     position: position
//     map: map,
//     title: 'Hello World!'
//   });

// var string_http = ['https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=',lat,',',lon,'&radius=500&type=restaurant&key=AIzaSyAVfs5AUpHDWv_RSr4x7sIhaDivbc6QaX4'].join("");

// console.log("string = " + string_http)
// $.ajax({
//   url: string_http ,
//   dataType: 'json',
//   crossDomain: true,
//   success: function(response) {
//     debugger;
//   }
// });

   


