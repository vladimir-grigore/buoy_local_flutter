import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class OfferDetailHeaderImage extends StatelessWidget {
  final Map offer;
  final Map offerLocation;

  OfferDetailHeaderImage({Key key, this.offer, this.offerLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var headerImage = offer['attributes']['categories'].contains('featured') ? 
    offer['attributes']['image']['default'] :
    offer['attributes']['thumbnail']['default'];

    return SizedBox(
      height: 250,
      child: Stack(
        children: <Widget>[
          Image(
            image: NetworkImageWithRetry(headerImage),
            fit: BoxFit.fitWidth,
            height: 250.0,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.0)],
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    offer['attributes']['merchant-name'],
                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    offerLocation['attributes']['city'],
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}