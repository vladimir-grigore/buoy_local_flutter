import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/Components/buoy_local_card.dart';
import 'package:buoy/Components/buoy_bucks.dart';
import 'package:buoy/model/AppState.dart';
import 'package:buoy/api/get_program_membership.dart';
import 'package:buoy/Pages/offers_list_page.dart';

class EarnPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: (){ print("Eat button pressed"); },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(
                    'images/eat-icon-text.png', 
                    fit: BoxFit.scaleDown, 
                    height: MediaQuery.of(context).size.height / 9,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){ print("Shop button pressed"); },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(
                    'images/shop-icon-text.png', 
                    fit: BoxFit.scaleDown, 
                    height: MediaQuery.of(context).size.height / 9,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){ print("Play button pressed"); },
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(
                    'images/play-icon-text.png', 
                    fit: BoxFit.scaleDown, 
                    height: MediaQuery.of(context).size.height / 9,
                  ),
                ),
              ),
            ],
          ),
          StoreConnector<AppState, FetchProgramMembership>(
            converter: (store) => () => store.dispatch(getProgramMembership),
            builder: (_, fetchApiDataCallback) {
              return new GestureDetector(
                onTap: (){ 
                  // Example of api call through Thunk middleware
                  // fetchApiDataCallback();

                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) { return OffersListPage(); }
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'images/find-deals-button.png', 
                    fit: BoxFit.scaleDown,
                    height: MediaQuery.of(context).size.height / 10,
                    alignment: Alignment.center,
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BuoyBucks(),
              Container( //Vertical divider
                height: 130.0,
                width: 1.0,
                color: Colors.black12,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
              BuoyLocalCardAndSwitch(),
            ],
          ),
        ],
      ),
    );
  }
}

typedef void FetchProgramMembership();
