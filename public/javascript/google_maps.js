getLocation();
var x = document.getElementById("map");


function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition,showError);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
      }
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


   



//----------Making markers---------------




var marker1 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[0].lat, gon.resteraunts[0].lng),
  label: gon.resteraunts[1],
  animation: google.maps.Animation.DROP
});

var marker2 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[2].lat, gon.resteraunts[2].lng),
  label: gon.resteraunts[3],
  animation: google.maps.Animation.DROP
});

var marker3 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[4].lat, gon.resteraunts[4].lng),
  label: gon.resteraunts[5],
  animation: google.maps.Animation.DROP
});

var marker4 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[6].lat, gon.resteraunts[6].lng),
  label: gon.resteraunts[7],
  animation: google.maps.Animation.DROP
});

var marker5 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[8].lat, gon.resteraunts[8].lng),
  label: gon.resteraunts[9],
  animation: google.maps.Animation.DROP
});

var marker6 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[10].lat, gon.resteraunts[10].lng),
  label: gon.resteraunts[11],
  animation: google.maps.Animation.DROP
});

var marker7 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[12].lat, gon.resteraunts[12].lng),
  label: gon.resteraunts[13],
  animation: google.maps.Animation.DROP
});

var marker8 = new google.maps.Marker({      
  position: new google.maps.LatLng(gon.resteraunts[14].lat, gon.resteraunts[15].lng),
  label: gon.resteraunts[15],
  animation: google.maps.Animation.DROP
});

// ----------------------Populates map-------------------------------------------------

  marker1.setMap(map);
  marker2.setMap(map);
  marker3.setMap(map);
  marker4.setMap(map);
  marker5.setMap(map);
  marker6.setMap(map);
  marker7.setMap(map);
  marker8.setMap(map);


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


// contents[i] = ['<p>',gon.resteraunts[(a - 1)],'</p>'].join("");


//     infowindows[i] = new google.maps.InfoWindow({
//         content: contents[i],
//         maxWidth: 300
//     });




