import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:buoy/api/get_location.dart';
import 'package:buoy/Components/opening_hours_dropdown.dart';

var kGoogleApiKey = DotEnv().env['GOOGLE_PLACES_API_KEY'];
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class OfferDetailsPage extends StatefulWidget {
  final Map offer;
  OfferDetailsPage({Key key, this.offer}) : super(key: key);

  @override
  _OfferDetailsPage createState() => _OfferDetailsPage();
}

class _OfferDetailsPage extends State<OfferDetailsPage> {
  String errorLoading;
  PlacesDetailsResponse place;
  bool isLoading = true;

  FutureOr Function(Map value) get onValue => null;

  @override
  void initState() {
    getLocation(widget.offer['id']).then((result) {
      fetchPlaceDetails(result['data'][0]['attributes']['google-place-id']);
    });

    super.initState();
  }

  fetchPlaceDetails(placeId) async {
    setState(() {
      this.errorLoading = null;
    });

    PlacesDetailsResponse place = await _places.getDetailsByPlaceId(placeId);

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

  ListView buildOfferDetails(PlaceDetails offerDetails) {
    List<Widget> list = [];

    // Display opening hours in an expansion panel
    if(offerDetails.openingHours != null) {
      final openingHours = offerDetails.openingHours;
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

    return ListView(
      shrinkWrap: true,
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody; 

    if(isLoading) {
      buildBody = Center(child: CircularProgressIndicator());
    } else if(errorLoading != null) {
      buildBody = Center(child: Text(errorLoading));
    } else {
      final offerDetails = place.result;

      buildBody = Column(
        children: <Widget>[
          Expanded(
            child: buildOfferDetails(offerDetails),
          
          ),
        ],
      );
    }
    
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text("Offer Details"),
      ),
      body: buildBody,
    );
  }
}
