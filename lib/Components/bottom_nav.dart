import 'package:flutter/material.dart';

import 'package:buoy/model/Store.dart';
import 'package:buoy/actions/buoy_actions.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key key}) : super(key: key);

  @override
  _BottomNav createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  _BottomNav();

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      currentIndex: store.state.tabIndex,
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
    );
  }
  
  void onTabTapped(int index) {
    store.dispatch(new UpdateTabIndexAction(index));
  }
}