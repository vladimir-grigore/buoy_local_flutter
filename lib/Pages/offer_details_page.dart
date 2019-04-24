import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:buoy/api/get_location.dart';
import 'package:buoy/Components/opening_hours_dropdown.dart';
import 'package:buoy/Components/offer_detail_header_image.dart';
import 'package:buoy/Components/location_details_map.dart';

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
  Map location;

  @override
  void initState() {
    getLocation(widget.offer['id']).then((result) {
      setState(() {
        this.location = result['data'][0];
      });
      fetchPlaceDetails(location['attributes']['google-place-id']);
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

  void _launchMapsUrl() async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${location['attributes']['latitude']},${location['attributes']['longitude']}';

    if(await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw "Could not open Google maps";
    }
  }

  void _launchPhoneApp(number) async {
    String phoneNumber = 'tel:$number';

    if(await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw "Could not open phone app";
    }
  }

  ListView buildOfferDetails(PlaceDetails offerDetails, Map offer, Map offerLocation) {
    List<Widget> list = [];

    list.add(
      OfferDetailHeaderImage(offer: offer, offerLocation: offerLocation)
    );

    list.add(
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Text("Offer", style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600
        )),
      )
    );

    list.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(color: Colors.black38)
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(offer['attributes']['title'], style: TextStyle(
                  color: Colors.indigo.shade700,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(offer['attributes']['details'], textAlign: TextAlign.center),
              )
            ],
          ),
        ),
      )
    );

    list.add(
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Text("Details", style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600
        )),
      )
    );

    list.add(
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text("ADDRESS", style: TextStyle(
          color: Colors.black26, fontSize: 12.0
        )),
      )
    );

    list.add(
      Padding(
        padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
        child: Text(offerLocation['attributes']['address'], style: TextStyle(
          color: Colors.black, fontSize: 15.0
        )),
      )
    );

    list.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(color: Colors.black38)
          ),
          child: LocationDetailsMap(place: place, height: 150.0),
        )
      )
    );

    list.add(
      Container(
        alignment: Alignment.centerLeft,
        child: FlatButton(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          onPressed: () {_launchMapsUrl();},
          child: Text("Get Directions", 
            style: TextStyle(color: Colors.indigo.shade700, fontSize: 20),
          ),
        ),
      )
    );
    
    if(offerLocation['attributes']['phone'] != null) {
      list.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("PHONE", style: TextStyle(
            color: Colors.black26, fontSize: 12.0
          )),
        )
      );

      list.add(
        Container(
          alignment: Alignment.centerLeft,
          child: FlatButton(
            padding: EdgeInsets.only(left: 20.0),
            onPressed: () {_launchPhoneApp(offerLocation['attributes']['phone']);},
            child: Text("${offerLocation['attributes']['phone']}", 
              style: TextStyle(color: Colors.indigo.shade700, fontSize: 15),
            ),
          ),
        )
      );
    }

    if(offerDetails.website != null) {
      list.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("WEBSITE", style: TextStyle(
            color: Colors.black26, fontSize: 12.0
          )),
        )
      );

      list.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Linkify(
            onOpen: (url) async {
              if(await canLaunch(offerDetails.website)) {
                await launch(offerDetails.website);
              } else {
                throw "Could not launch ${offerDetails.website}";
              }
            },
            text: offerDetails.website, 
            linkStyle: TextStyle(color: Colors.indigo.shade700)
          ),
        )
      );
    }

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
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 20.0),
          child: Text("HOURS", style: TextStyle(
            color: Colors.black26, fontSize: 12.0
          )),
        )
      );

      list.add(
        SingleChildScrollView(
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 100),
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
      final offer = widget.offer;
      final offerLocation = location;

      buildBody = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: buildOfferDetails(offerDetails, offer, offerLocation),
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
