import 'package:flutter/material.dart';
import 'package:buoy/Pages/home_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/model/Store.dart';

void main() async {
  // Remote dev tools is used for Redux debugging in the browser
  // Start the debugger with "remotedev --port 8000"
  remoteDevtools.store = store;
  await remoteDevtools.connect();

  runApp(MyApp(
    store: store
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Buoy Local Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: MyHomePage(title: 'Home'),
      ),
    );
  }
}
