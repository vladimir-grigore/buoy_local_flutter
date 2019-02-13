import 'package:flutter/material.dart';

class EarnPage extends StatefulWidget {
  EarnPage({ Key key }) : super(key: key);

  @override
  _EarnPageState createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> {
  final buoyBucks = 12.51;
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: (){ print("Eat button pressed"); },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(
                    'images/eat-icon-text.png', 
                    fit: BoxFit.scaleDown, 
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){ print("Shop button pressed"); },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(
                    'images/shop-icon-text.png', 
                    fit: BoxFit.scaleDown, 
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){ print("Play button pressed"); },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(
                    'images/play-icon-text.png', 
                    fit: BoxFit.scaleDown, 
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){ print("Find deals button pressed"); },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/find-deals-button.png', 
                fit: BoxFit.scaleDown,
                height: MediaQuery.of(context).size.height / 10,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){ print("Buoy Bucks clicked"); },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      width: MediaQuery.of(context).size.width / 3,
                      child: Image.asset(
                        'images/buoy-bucks-container.png', 
                        fit: BoxFit.fitWidth, 
                        height: MediaQuery.of(context).size.height / 6,
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 35),
                    child: Text('\$$buoyBucks', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Container(
                height: 130.0,
                width: 1.0,
                color: Colors.black12,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){ print("Buoy card clicked"); },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      width: MediaQuery.of(context).size.width / 3,
                      child: Opacity(
                        opacity: status ? 1.0 : 0.5,
                        child: Image.asset(
                          'images/buoy-local-card-v2.png', 
                          fit: BoxFit.fitWidth, 
                          height: MediaQuery.of(context).size.height / 7,
                          ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Switch(
                        value: status,
                        onChanged: (bool newValue){ 
                          setState(() {
                            status = newValue;
                          });
                          print("Switch is $status"); 
                        },
                      ),
                      Container(
                        width: 80,
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(status ? "Unlocked" : "Locked"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
