import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/actions/buoy_actions.dart';

ThunkAction<AppState> fetchApiData = (Store<AppState> store) async {
  http.Response response = await http.get(
    'http://api.paywith.127.0.0.1.nip.io:3200/v2/program-memberships?program_id=8700&include=active_card,program,active_funding_source',
    headers: {
      "Authorization": "Bearer 535bf097bed270f45ee592491f470a056daa1a5b03b6972a12d5fe6aced66171",
      "Content-type": "application/json", "Accept": "application/json"
    },
  );

  Map<String, dynamic> result = json.decode(response.body);

  store.dispatch(new UpdateProgramMembershipAction(result));
};
