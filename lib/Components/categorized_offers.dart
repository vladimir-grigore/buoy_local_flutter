import 'package:flutter/material.dart';

import 'package:buoy/Components/featured_offers.dart';
import 'package:buoy/Components/offers_horizontal_list.dart';

class CategorizedOffers extends StatelessWidget {
  final List offers;
  CategorizedOffers({Key key, this.offers}) : super(key: key);

  categorizeOffers(offers) {
    var categories = {};

    offers.forEach((offer) {
      offer['attributes']['categories'].forEach((category) {
        categories[category] = categories[category] ?? [];
        categories[category].add(offer);
      });
    });

    return categories;
  }

  List<Widget> buildOffersListview(categorizedOffers) {
    List<Widget> list = [];

    if(categorizedOffers['featured'] != null) {
      list.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: FeaturedOffers(featuredOffers: categorizedOffers['featured']),
        ),
      );
    }

    if(categorizedOffers['eat'] != null) {
      list.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("EAT"),
        ),
      );

      list.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OffersHorizontalList(offersList: categorizedOffers['eat']),
        ),
      );
    }

    if(categorizedOffers['shop'] != null) {
      list.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("SHOP"),
        ),
      );

      list.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OffersHorizontalList(offersList: categorizedOffers['shop']),
        ),
      );
    }

    if(categorizedOffers['play'] != null) {
      list.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("PLAY"),
        ),
      );

      list.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OffersHorizontalList(offersList: categorizedOffers['play']),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final categorizedOffers = categorizeOffers(offers);
    return ListView(
      shrinkWrap: true,
      children: buildOffersListview(categorizedOffers),
    );
  }
}
