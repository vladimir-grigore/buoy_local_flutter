import 'package:flutter/material.dart';

class OfferTile extends StatelessWidget {
  final Map<String, dynamic> offer;
  OfferTile({ Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 5.0)
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: Colors.white,
              height: 300,
              child: Image.network(
                offer['attributes']['thumbnail']['default'],
                fit: BoxFit.fitHeight,
                width: 150.0,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Container(
              color: Colors.white,
              width: 150,
              height: 55,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      offer['attributes']['title'],
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ), 
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      offer['attributes']['merchant-name'],
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    
    
    
  }
}
