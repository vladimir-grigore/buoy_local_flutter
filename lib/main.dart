import 'package:flutter/material.dart';

void main() => runApp(MyApp());

typedef RedeemCallback = void Function(double newValue);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buoy Local Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double points = 1241.0;
  double redeemed = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BuoyHeader(points: points, redeemed: redeemed),
            TabContainer(
              points: points,
              onPointsRedeem: (newValue) {
                setState(() {
                  redeemed = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BuoyHeader extends StatefulWidget {
  final double points;
  final double redeemed;
  BuoyHeader({Key key, this.points, this.redeemed}) : super(key: key);
  
  _BuoyHeaderState createState() => _BuoyHeaderState();
}

class _BuoyHeaderState extends State<BuoyHeader> {

  @override
  Widget build(BuildContext context) {
    double spinnerValue = widget.redeemed == 0.0 ? 1.0 :  (widget.points - widget.redeemed) / widget.points;

    return Stack(
      alignment: Alignment(0.0, 0.0),
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'images/header-bangor-image.png', 
            fit: BoxFit.fitWidth, 
            height: MediaQuery.of(context).size.height / 4,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: <Widget>[
              Text("MY POINTS", style: TextStyle(color: Colors.white)),
              Text("${(widget.points - widget.redeemed).toInt()}", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Center(
          child: Stack(
            alignment: Alignment(0.0, 1.3),
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 30.0),
                width: MediaQuery.of(context).size.width / 5,
                child: Image.asset(
                  'images/points-buoy.png', 
                  fit: BoxFit.fitWidth, 
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(-131 / 360),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    value: spinnerValue / 1.5,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(
                  'images/waves-header.png', 
                  fit: BoxFit.fitWidth, 
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabContainer extends StatefulWidget {
  final double points;
  final RedeemCallback onPointsRedeem;
  TabContainer({ Key key, this.points, this.onPointsRedeem }) : super(key: key);

  @override
  _TabContainer createState() => _TabContainer();
}

class _TabContainer extends State<TabContainer> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.indigo.shade700,
            appBar: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(text: "EARN"),
                Tab(text: "REDEEM"),
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                EarnPage(),
                RedeemPage(points: widget.points, onPointsRedeem: widget.onPointsRedeem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){ print("Buoy Bucks clicked"); },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      width: MediaQuery.of(context).size.width / 3,
                      child: Image.asset(
                        'images/buoy-bucks-container.png', 
                        fit: BoxFit.fitWidth, 
                        height: MediaQuery.of(context).size.height / 5,
                        ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    bottom: 25,
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
            children: <Widget>[
              GestureDetector(
                onTap: (){ print("Buoy Bucks clicked"); },
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset('images/buoy-bucks-container.png', fit: BoxFit.fitWidth),
                ),
              ),
              Positioned(
                left: 35,
                bottom: 45,
                width: 150,
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
