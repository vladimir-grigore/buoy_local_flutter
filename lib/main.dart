import 'package:flutter/material.dart';
import 'package:buoy/Pages/home_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/reducers/app_reducer.dart';


void main() async {
  // Remote dev tools is used for Redux debugging in the browser
  // Start the debugger with "remotedev --port 8000"
  var remoteDevtools = RemoteDevToolsMiddleware('0.0.0.0:8000');

  final store = new DevToolsStore<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [thunkMiddleware, remoteDevtools],
  );

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
