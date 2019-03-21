import 'package:flutter/material.dart';

import 'package:buoy/Components/tab_container.dart';
import 'package:buoy/Components/buoy_header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text("Home"),
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
    );
  }
}
