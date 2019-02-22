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
        );
      },
    );
  }
}
