import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/actions/buoy_actions.dart';

//ThunkAction is a flutter middleware
ThunkAction<AppState> getProgramMembership = (Store<AppState> store) async {
  store.dispatch(new ToggleLoadingScreenAction());
    // When using localhost
    // var host = "api.paywith.127.0.0.1.nip.io:3200";
    var host = 'staging-app.paywith.com';

    if(Platform.isAndroid){
      // When using localhost
      // host = 'api.paywith.10.0.2.2.nip.io:3200';
    }

  http.Response response = await http.get(
    'http://$host/v2/program-memberships?program_id=8700&include=active_card,program,active_funding_source',
    headers: {
      "Authorization": "Bearer 535bf097bed270f45ee592491f470a056daa1a5b03b6972a12d5fe6aced66171",
      "Content-type": "application/json", "Accept": "application/json"
    },
  );

  Map<String, dynamic> result = json.decode(response.body);

  store.dispatch(new UpdateProgramMembershipAction(result));
  store.dispatch(new ToggleLoadingScreenAction());
};
