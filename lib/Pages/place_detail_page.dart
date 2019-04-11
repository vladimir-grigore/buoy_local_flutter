import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var kGoogleApiKey = DotEnv().env['GOOGLE_PLACES_API_KEY'];
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class PlaceDetailPage extends StatefulWidget {
  final String placeId;
  PlaceDetailPage({Key key, this.placeId}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetailPage> {
  GoogleMapController mapController;
  bool isLoading = false;
  String errorLoading;
  PlacesDetailsResponse place;
  final Set<Marker> marker = {};

  @override
  void initState() {
    fetchPlaceDetails();
    super.initState();
  }

  void fetchPlaceDetails() async {
    setState(() {
      this.isLoading = true;
      this.errorLoading = null;
    });

    PlacesDetailsResponse place = await _places.getDetailsByPlaceId(widget.placeId);

    if(mounted) {
      setState(() {
        this.isLoading = false;
        if(place.status == "OK") {
          this.place = place;
        } else {
          this.errorLoading = place.errorMessage;
        }
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    final location = place.result.geometry.location;
    final center = LatLng(location.lat, location.lng);

    marker.add(
      Marker(
        markerId: MarkerId(place.hashCode.toString()),
        position: center,
        infoWindow: InfoWindow(
          title: place.result.name,
          snippet: place.result.formattedAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      )
    ); 
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyChild;
    String title;

    if (isLoading) {
      title = "Loading";
      bodyChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorLoading != null) {
      title = "";
      bodyChild = Center(child: Text(errorLoading));
    } else {
      final placeDetails = place.result;
      final location = place.result.geometry.location;
      final center = LatLng(location.lat, location.lng);

      title = placeDetails.name;
      bodyChild = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: SizedBox(
              height: 200.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: marker,
                initialCameraPosition: CameraPosition(
                  target: center, zoom: 15.0,
                ),
              ),
            ),
          ),
          Expanded(
            // child: buildPlaceDetailsList(placeDetails),
            child: Center(child: Text("In progress"))
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: bodyChild,
    );
  }
}