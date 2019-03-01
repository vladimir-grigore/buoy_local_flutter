import 'package:flutter/material.dart';
import 'package:buoy/Pages/home_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/reducers/app_reducer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [new LoggingMiddleware.printer(), thunkMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
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
