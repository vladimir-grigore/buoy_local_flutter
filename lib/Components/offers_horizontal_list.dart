import 'package:flutter/material.dart';

import 'package:buoy/Components/offer_tile.dart';

class OffersHorizontalList extends StatelessWidget {
  final List offersList;
  OffersHorizontalList({ Key key, this.offersList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offersList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
            child: OfferTile(offer: offersList[index]),            
          );
        },
      ),
    );
  }
}
