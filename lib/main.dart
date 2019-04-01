import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/rendering.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/model/Store.dart';
import 'package:buoy/app.dart';

var remoteDevtools = RemoteDevToolsMiddleware('localhost:8000');
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

selectHost() async {
  if(Platform.isAndroid){
    remoteDevtools = RemoteDevToolsMiddleware('10.0.2.2:8000');
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    
    // Connect to remote dev tools only if app is running on an emulator
    if(!androidInfo.isPhysicalDevice) {
      remoteDevtools.store = store;
      await remoteDevtools.connect();
    }
  } else if(Platform.isIOS) {
    remoteDevtools = RemoteDevToolsMiddleware('127.0.0.1:8000');
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    // Connect to remote dev tools only if app is running on an emulator
    if(!iosInfo.isPhysicalDevice) {
      remoteDevtools.store = store;
      await remoteDevtools.connect();
    }
  }
}

void main() async {
  // Remote dev tools is used for Redux debugging in the browser
  // Start the debugger with "remotedev --port 8000"
  selectHost();

  // Used for displaying padding and component dimensions
  debugPaintSizeEnabled=false;

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
