import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;

const kGoogleApiKey = "AIzaSyCDJdRx5tLyIPfpUBSChJ5mmkfzjad9sWA";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class LocationsPage extends StatefulWidget {
  LocationsPage({Key key}) : super(key: key);

  @override
  _LocationsPage createState() => _LocationsPage();
}

class _LocationsPage extends State<LocationsPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  final Set<Marker> _markers = {};
  bool isLoading = false;
  String errorMessage;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
    refresh();
  }

  void refresh() async {
    // Immediately after the map is loaded, the app asks for device location
    // If location is received the map will zoom in centering on the device location
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: center == null ? LatLng(0.0, 0.0) : center, zoom: 12.0
    )));

    getNearbyPlaces(center);
  }

  Future<LatLng> getUserLocation() async {
    final location = LocationManager.Location();

    try{
      var currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
      print("$lat,$lng");
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude, center.latitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);

    setState(() {
      this.isLoading = false;
      if(result.status == 'OK') {
        this.places = result.results;
        result.results.forEach((f) {
          // TODO: add markers to _markers
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: SizedBox(
              height: 200.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(0.0, 0.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
