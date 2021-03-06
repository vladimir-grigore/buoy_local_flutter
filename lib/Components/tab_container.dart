import 'package:flutter/material.dart';

import 'package:buoy/Pages/redeem_page.dart';
import 'package:buoy/Pages/earn_page.dart';

class TabContainer extends StatelessWidget {
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
                RedeemPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
