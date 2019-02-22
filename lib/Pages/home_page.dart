import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/Components/tab_container.dart';
import 'package:buoy/Components/buoy_header.dart';
import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade700,
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                BuoyHeader(),
                TabContainer(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            type:BottomNavigationBarType.fixed,
            fixedColor: Colors.indigo,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home, color: Colors.grey),
                title: new Text("Home", style: TextStyle(color: Colors.grey)),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.location_on, color: Colors.grey),
                title: new Text("Locations", style: TextStyle(color: Colors.grey)),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.history, color: Colors.grey),
                title: new Text("History", style: TextStyle(color: Colors.grey)),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.credit_card, color: Colors.grey),
                title: new Text("Card", style: TextStyle(color: Colors.grey)),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.more_horiz, color: Colors.grey),
                title: new Text("More", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        );
      },
    );
  }
}
