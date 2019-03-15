import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:buoy/model/AppState.dart';
import 'package:buoy/reducers/app_reducer.dart';


// Remote dev tools is used for Redux debugging in the browser
// Start the debugger with "remotedev --port 8000"
var remoteDevtools = RemoteDevToolsMiddleware('0.0.0.0:8000');


final store = new DevToolsStore<AppState>(
  appReducer,
  initialState: new AppState(),
  middleware: [thunkMiddleware, remoteDevtools],
);
