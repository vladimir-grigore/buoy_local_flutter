import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;

import 'package:buoy/Pages/place_detail_page.dart';

var kGoogleApiKey = DotEnv().env['GOOGLE_PLACES_API_KEY'];
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
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
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

  // Build a list of google places and store it in the _markers set
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
                snippet: f.types?.first,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            )
          );
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage))
    );
  }

  // Googple places search functionality
  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        strictbounds: center == null ? false : true,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: Mode.overlay,
        language: "en",
        location: center == null ? null : Location(center.latitude, center.longitude),
        radius: center == null ? null : 10000
      );

      showDetailsPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  // Redirect to the place details page
  Future<Null> showDetailsPlace(String placeId) async {
    if(placeId != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => PlaceDetailPage(placeId: placeId)
      ));
    }
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
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("Locations"),
        backgroundColor: Colors.indigo.shade700,
        actions: <Widget>[
          isLoading 
            ? IconButton(icon: Icon(Icons.timer), onPressed: () {}) 
            : IconButton(icon: Icon(Icons.refresh), onPressed: () {refresh();}),
            IconButton(icon: Icon(Icons.search), onPressed: () {_handlePressButton();})
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: SizedBox(
              height: 250.0,
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

  // Builds the Google places scroll list
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
              showDetailsPlace(f.placeId);
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
