import 'package:flutter/material.dart';

typedef RedeemCallback = void Function(double newValue);

class RedeemPage extends StatefulWidget {
  final double points;
  final RedeemCallback onPointsRedeem;
  RedeemPage({ Key key, this.points, this.onPointsRedeem }) : super(key: key);

  @override
  _RedeemPageState createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  int pointsRedeemed = 0;
  String redeemedCash = "0.00";
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              GestureDetector(
                onTap: (){ print("Buoy Bucks clicked"); },
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset('images/buoy-bucks-container.png', fit: BoxFit.fitWidth),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.2,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('\$$redeemedCash', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Redeem"),
                        Text("$pointsRedeemed pts"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Slider(
              min: 0.0,
              max: widget.points,
              value: _sliderValue,
              onChanged: (newRating) {
                widget.onPointsRedeem(newRating);
                setState(() {
                  _sliderValue = newRating;
                  pointsRedeemed = newRating.round();
                  redeemedCash = (pointsRedeemed / 100).toStringAsFixed(2);
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              onPressed: pointsRedeemed > 0 ? (){
                print("Cash redeem button pressed");
              } : null,
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              disabledTextColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Text("REDEEM POINTS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
            ),
          ),
        ],
      ),
    );
  }
}