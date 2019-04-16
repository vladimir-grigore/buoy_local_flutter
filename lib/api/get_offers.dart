import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:buoy/actions/buoy_actions.dart';
import 'package:buoy/model/Store.dart';

Future<Map> getOffers({location='Greater Bangor'}) async {
  // When using localhost
  // var host = "api.paywith.127.0.0.1.nip.io:3200";
  var host = 'staging-app.paywith.com';

  if(Platform.isAndroid){
    // When using localhost
    // host = 'api.paywith.10.0.2.2.nip.io:3200';
  }

  String getLocationId(location) {
    switch (location) {
      case 'Aroostook':
        return 'aroostook';
        break;
      case 'Downeast & Acadia':
        return 'acadia';
        break;
      case 'Kennebec & Moose River Valleys':
        return 'kennebec';
        break;
      case 'Maine Highlands':
        return 'highlands';
        break;
      case 'Maine Lakes & Mountains':
        return 'lakes';
        break;
      case 'Mid-Coast':
        return 'midcoast';
        break;
      case 'South Coast':
        return 'southcoast';
        break;
      case 'Greater Bangor':
        return 'bangor';
        break;
      case 'Greater Portland':
        return 'portland';
        break;
      default:
        break;
    }
  }

  http.Response response = await http.get(
    'http://$host/v2/offers?program_id=8700&filter[location_tag]=${getLocationId(location)}',
    headers: {
      "Authorization": "Bearer 535bf097bed270f45ee592491f470a056daa1a5b03b6972a12d5fe6aced66171",
      "Content-type": "application/json", "Accept": "application/json"
    },
  );

  Map<String, dynamic> result = json.decode(response.body);
  store.dispatch(new UpdateOffersAction(result));

  return result;
}
