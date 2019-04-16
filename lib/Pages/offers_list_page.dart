import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';
import 'package:buoy/api/get_offers.dart';
import 'package:buoy/Components/location_dropdown.dart';

class OffersListPage extends StatefulWidget {
  OffersListPage({Key key}) : super(key: key);

  @override
  _OffersListPage createState() => _OffersListPage();
}

class _OffersListPage extends State<OffersListPage> {
  _OffersListPage();
  String dropdownValue = 'Greater Bangor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text("Offers"),
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: ViewModel.fromStore,
        builder: (BuildContext context, ViewModel vm) {
          var offers = vm.offers;
          
          if(offers != null) {
            return Column(
              children: <Widget>[
                LocationDropdown(),
                Center(
                  child: Text(offers.toString()),
                ),
              ],
            );
          } else {
            return FutureBuilder(
              future: getOffers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data != null) {
                    offers = snapshot.data['data'];

                    return Column(
                      children: <Widget>[
                        LocationDropdown(),
                        Center(
                          child: Text(offers.toString()),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}