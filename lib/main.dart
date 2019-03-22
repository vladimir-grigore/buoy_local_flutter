import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'dart:io' show Platform;

import 'package:buoy/model/AppState.dart';
import 'package:buoy/model/Store.dart';
import 'package:buoy/app.dart';

var remoteDevtools = RemoteDevToolsMiddleware('localhost:8000');

selectHost() {
  if(Platform.isAndroid){
    remoteDevtools = RemoteDevToolsMiddleware('10.0.2.2:8000');
  } else if(Platform.isIOS) {
    remoteDevtools = RemoteDevToolsMiddleware('127.0.0.1:8000');
  } 
}

void main() async {
  selectHost();
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
        home: AppWidget(),
      ),
    );
  }
}
