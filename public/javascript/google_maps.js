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

    var marker = new google.maps.Marker({
        position: resteraunt1,
        title: gon.resteraunts[3]
    });

    var marker2 = new google.maps.Marker({
        position: resteraunt2,
        title: gon.resteraunts[5]
    });

    var marker3 = new google.maps.Marker({
        position: resteraunt3,
        title: gon.resteraunts[7]
    });

    var marker4 = new google.maps.Marker({
        position: resteraunt4,
        title: gon.resteraunts[9],
        labelContent: "$425K"
    });

    var marker5 = new google.maps.Marker({
        position: resteraunt5,
        title: gon.resteraunts[11]
    });

    var marker6 = new google.maps.Marker({
        position: resteraunt6,
        title: gon.resteraunts[13]
    });

    var marker7 = new google.maps.Marker({
        position: resteraunt7,
        title: gon.resteraunts[15]
    });

    var marker8 = new google.maps.Marker({
        position: resteraunt8,
        title: gon.resteraunts[17]
    });


    

    //----------Add marker to the map---------------
    marker.setMap(map);
    marker2.setMap(map);
    marker3.setMap(map);
    marker4.setMap(map);
    marker5.setMap(map);
    marker6.setMap(map);
    marker7.setMap(map);
    marker8.setMap(map);


}

// ----------------------Populates map--------------------------------------------------
var resteraunt1 = new google.maps.LatLng(gon.resteraunts[2].lat,gon.resteraunts[2].lng);
var resteraunt2 = new google.maps.LatLng(gon.resteraunts[4].lat,gon.resteraunts[4].lng);
var resteraunt3 = new google.maps.LatLng(gon.resteraunts[6].lat,gon.resteraunts[6].lng);
var resteraunt4 = new google.maps.LatLng(gon.resteraunts[8].lat,gon.resteraunts[8].lng);
var resteraunt5 = new google.maps.LatLng(gon.resteraunts[10].lat,gon.resteraunts[12].lng);
var resteraunt6 = new google.maps.LatLng(gon.resteraunts[14].lat,gon.resteraunts[14].lng);
var resteraunt7 = new google.maps.LatLng(gon.resteraunts[16].lat,gon.resteraunts[16].lng);
var resteraunt8 = new google.maps.LatLng(gon.resteraunts[18].lat,gon.resteraunts[18].lng);

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

   


