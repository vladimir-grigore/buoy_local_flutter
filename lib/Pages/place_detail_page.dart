import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
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

  // The place details has a horizontal image scroll list followed by other details
  ListView buildPlaceDetailsList(PlaceDetails placeDetails) {
    List<Widget> list = [];

    if(placeDetails.photos != null) {
      final photos = placeDetails.photos;

      list.add(SizedBox(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 1.0),
              child: SizedBox(
                height: 150,
                child: Image.network(
                  buildPhotoURL(photos[index].photoReference)
                ),
              ),
            );
          },
        ),
      ));
    }

    list.add(Padding(
      padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
      child: Text(placeDetails.name, style: Theme.of(context).textTheme.headline),
    ));

    if(placeDetails.formattedAddress != null) {
      list.add(Padding(
        padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: Text(placeDetails.formattedAddress, style: Theme.of(context).textTheme.subhead),
      ));
    }

    if(placeDetails.types?.first != null) {
      list.add(Padding(
        padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: Text(placeDetails.types.first.toUpperCase(), style: Theme.of(context).textTheme.caption),
      ));
    }

    if(placeDetails.formattedPhoneNumber != null) {
      list.add(Padding(
        padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: Text(placeDetails.formattedPhoneNumber, style: Theme.of(context).textTheme.button),
      ));
    }

    if(placeDetails.openingHours != null) {
      final openingHours = placeDetails.openingHours;
      var text = openingHours.openNow ? "Open Now" : "Closed";

      list.add(Padding(
        padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: Text(text, style: Theme.of(context).textTheme.caption),
      ));
    }

    if(placeDetails.website != null) {
      list.add(Padding(
        padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: Linkify(
          onOpen: (url) async {
            if(await canLaunch(placeDetails.website)) {
              await launch(placeDetails.website);
            } else {
              throw "Could not launch ${placeDetails.website}";
            }
          },
          text: placeDetails.website, 
          style: Theme.of(context).textTheme.body2
        ),
      ));
    }

    if(placeDetails.rating != null) {
      list.add(Padding(
        padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: Text("Rating: ${placeDetails.rating}", style: Theme.of(context).textTheme.caption),
      ));
    }

    return ListView(
      shrinkWrap: true,
      children: list,
    );
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
              height: 250.0,
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
            child: buildPlaceDetailsList(placeDetails),
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
