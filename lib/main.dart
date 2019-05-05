import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geomel',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyStatefulWidget(),
    );
  }
  
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();

  }

class _MyStatefulWidgetState extends State<MyStatefulWidget>  {

  Geolocator geolocator = Geolocator();
  LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10, timeInterval: 2000);
  double latitude;
  double longitude;
  List<String> _listaLocalSalvo = [];


  Completer<GoogleMapController> _controller = Completer();

  static LatLng _center;
  final Set<Marker> _markers = {};
  int contIScas = 1;
  
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    
  }

  @override
  void initState() {
    super.initState();
    geolocator.getPositionStream(locationOptions).listen((Position posicao) {
      setState(() {
        latitude = posicao.latitude;
        longitude = posicao.longitude;
        _center = LatLng(latitude, longitude);
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocalização de Iscas'),
          ),
      body: Stack(
      children: <Widget>[
        Center(
              child: Text('Latitude: ' + latitude.toString() +
              ' Longitude: ' + longitude.toString()),
          ),
        
        GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition( target: _center, zoom: 17.0),
       ),

        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
              onPressed: _addIsca,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.orange,
              tooltip: 'Marcar localização no Mapa',
              child: Icon(Icons.add_location),
        ),
              ),
    ),
  ],
),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
 
  );
}

  void _addIsca() {
    LatLng markerMapPosition = LatLng(latitude, longitude);
    setState(() {
      _listaLocalSalvo.add(latitude.toString() + ',' + longitude.toString());
      _gravaListaLocaisSalvos();
      
      _markers.add(Marker (
        
        markerId: MarkerId(markerMapPosition.toString()),
        position:markerMapPosition,
        infoWindow: InfoWindow(
          title: 'Isca $contIScas',
          snippet: 'Abelha Jataí',
          ),
          icon: BitmapDescriptor.defaultMarker,
          ));
    });
    
    
    contIScas++;
    }

  _gravaListaLocaisSalvos() async {
    final database = await SharedPreferences.getInstance();
    final chave = 'lista_locais_salvos';
    database.setStringList(chave, _listaLocalSalvo);
  }

}