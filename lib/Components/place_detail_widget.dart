import 'package:flutter/material.dart';

class PlaceDetailWidget extends StatefulWidget {
  final String placeId;
  PlaceDetailWidget({Key key, this.placeId}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place detail widget")
      ),
      body: Center(child: Text("PlaceId: ${widget.placeId}"))
    );
  }
}