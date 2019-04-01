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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(49.2827, -123.1207),
          zoom: 11.4746,
        ),
      ),
    );
  }
}
