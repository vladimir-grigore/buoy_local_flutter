import 'package:flutter/material.dart';

class OfferDetailsPage extends StatefulWidget {
  final Map offer;
  OfferDetailsPage({Key key, this.offer}) : super(key: key);

  @override
  _OfferDetailsPage createState() => _OfferDetailsPage();
}

class _OfferDetailsPage extends State<OfferDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text("Offer Details"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                "${widget.offer.toString()}"
              ),
            ),
          ),
        ],
      ),
    );
  }
}