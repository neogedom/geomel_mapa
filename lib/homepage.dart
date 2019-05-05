import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

double zoomVal = 5.0;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_left),
        onPressed: () {

        }),
        title: Text("GeoMel"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {

            }),
        ],
    ),
    body: Stack(
      children: <Widget>[
        _googleMap(context),
       // _zoomminusfunction(),
       // _zoomplusfunction(),
       // _buildContainer(),
      ],
    ),
  );
  
}

Widget _googleMap(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: LatLng(-15.77972, -47.92972), zoom: 12),
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
      },
      
      markers:{
        trapMarker1, trapMarker2
      },
    ),
  );
}

/*Widget _buildContainer() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: boxes(
              "Isca 1"
            ),
          ),
          SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: boxes(
              "Isca 1"
            ),
          ),
          SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: boxes(
              "Isca 1"
            ),
          )
        ],
      ),
    ),
  )
}
}*/

Marker trapMarker1 = Marker(
  markerId: MarkerId('isca1'),
  position: LatLng(-15.77030, -47.92472),
  infoWindow: InfoWindow(title: 'Isca 1'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),

); 

Marker trapMarker2 = Marker(
  markerId: MarkerId('isca2'),
  position: LatLng(-15.77030, -47.92472),
  infoWindow: InfoWindow(title: 'Isca 2'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueOrange,
  ),

);} 