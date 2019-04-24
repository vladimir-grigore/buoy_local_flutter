import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:buoy/Components/opening_hours_dropdown.dart';
import 'package:buoy/Components/location_details_map.dart';

var kGoogleApiKey = DotEnv().env['GOOGLE_PLACES_API_KEY'];
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class PlaceDetailPage extends StatefulWidget {
  final String placeId;
  PlaceDetailPage({Key key, this.placeId}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetailPage> {
  bool isLoading = false;
  String errorLoading;
  PlacesDetailsResponse place;

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

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$kGoogleApiKey";
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
          itemBuilder: (BuildContext context, int index) {
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

    // Display opening hours in an expansion panel
    if(placeDetails.openingHours != null) {
      final openingHours = placeDetails.openingHours;
      var text = openingHours.openNow ? "Open Now" : "Closed";
      List<Widget>hours = [];

      openingHours.weekdayText.forEach((day){
        hours.add(
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(day),
          )
        );
      });

      List<OpenHours> items = <OpenHours>[
        OpenHours(false, text,
          Column(
            children: hours,
          )
        ),
      ];

      list.add(
        SingleChildScrollView(
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 100),
              child: OpeningHoursDropdown(openingHours: items),
            ),
          ),
        )
      );
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
      bodyChild = Center(child: CircularProgressIndicator());
    } else if (errorLoading != null) {
      title = "";
      bodyChild = Center(child: Text(errorLoading));
    } else {
      final placeDetails = place.result;

      title = placeDetails.name;
      bodyChild = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: LocationDetailsMap(place: place, height: 250.0),
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
