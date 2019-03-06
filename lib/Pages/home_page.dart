import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/Components/tab_container.dart';
import 'package:buoy/Components/buoy_header.dart';
import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

import 'package:buoy/Pages/placeholder_page.dart';
import 'package:buoy/Pages/transactions_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  
  final List<Widget> _children = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          BuoyHeader(),
          TabContainer(),
        ],
      ),
    ),
    PlaceholderPage(Colors.deepOrange, "Locations page"),
    TransactionsPage(Colors.deepPurple),
    PlaceholderPage(Colors.green, "Card page"),
    PlaceholderPage(Colors.lightBlue, "More page"),
  ];

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
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.location_on),
                title: new Text("Locations"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.history),
                title: new Text("History"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.credit_card),
                title: new Text("Card"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.more_horiz),
                title: new Text("More"),
              ),
            ],
          ),
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
