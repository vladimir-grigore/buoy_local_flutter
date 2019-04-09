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

    mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: center == null ? LatLng(0.0, 0.0) : center, zoom: 14.0
    )));

    getNearbyPlaces(center);
  }

  Future<LatLng> getUserLocation() async {
    final location = LocationManager.Location();

    try{
      var currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
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

    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 500);

    setState(() {
      this.isLoading = false;
      if(result.status == 'OK') {
        this.places = result.results;
        result.results.forEach((f) {
          _markers.add(
            Marker(
              markerId: MarkerId(f.hashCode.toString()),
              position: LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindow: InfoWindow(
                title: f.name,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
            )
          );
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget expandedChild;

    if(isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if(errorMessage != null) {
      expandedChild = Center(child: Text(errorMessage));
    } else {
      expandedChild = buildPlacesList();
    }

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
          Expanded(child: expandedChild),
        ],
      ),
    );
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(f.name, style: Theme.of(context).textTheme.subtitle),
        )
      ];

      if(f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(f.formattedAddress, style: Theme.of(context).textTheme.subtitle),
        ));
      }

      if(f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(f.vicinity, style: Theme.of(context).textTheme.body1),
        ));
      }

      if(f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(f.types.first, style: Theme.of(context).textTheme.caption),
        ));
      }

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              // showDetailPlace(f.placeId);
            },
            highlightColor: Colors.indigoAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
}
