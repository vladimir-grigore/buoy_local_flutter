import 'package:flutter/material.dart';
import 'package:buoy/Components/tab_container.dart';
import 'package:buoy/Components/buoy_header.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double points = 12341.0;
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
