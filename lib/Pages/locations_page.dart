import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationsPage extends StatefulWidget {
  LocationsPage({Key key}) : super(key: key);

  @override
  _LocationsPage createState() => _LocationsPage();
}

class _LocationsPage extends State<LocationsPage> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  static const LatLng _center = const LatLng(49.2827, -123.1207);
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: "Test map marker",
            snippet: '4.5 star rating',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _currentMapType,
            onMapCreated: _onMapCreated,
            markers: _markers,
            onCameraMove: _onCameraMove,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.indigo.shade700,
                    child: Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.indigo.shade700,
                    child: Icon(Icons.add_location, size: 36.0),
                  )
                ],
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
