import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:buoy/actions/buoy_actions.dart';
import 'package:buoy/model/Store.dart';

Future<Map> getActiveTransaction(transactionId) async {
  var host = "api.paywith.127.0.0.1.nip.io:3200";

  if(Platform.isAndroid){
    host = 'api.paywith.10.0.2.2.nip.io:3200';
  }

  http.Response response = await http.get(
    'http://$host/v2/transactions/$transactionId?include=location',
    headers: {
      "Authorization": "Bearer 535bf097bed270f45ee592491f470a056daa1a5b03b6972a12d5fe6aced66171",
      "Content-type": "application/json", "Accept": "application/json"
    },
  );

  Map<String, dynamic> result = json.decode(response.body);
  store.dispatch(new UpdateActiveTransactionAction(result));

  return result;
}
