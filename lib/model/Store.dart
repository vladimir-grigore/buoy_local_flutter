import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/reducers/app_reducer.dart';
import 'package:buoy/main.dart';

final store = new DevToolsStore<AppState>(
  appReducer,
  initialState: new AppState(),
  middleware: [thunkMiddleware, remoteDevtools],
);
