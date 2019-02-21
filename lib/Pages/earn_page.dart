import 'package:flutter/material.dart';

import 'package:buoy/Components/buoy_local_card.dart';
import 'package:buoy/Components/buoy_bucks.dart';

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
                    height: MediaQuery.of(context).size.height / 8,
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
                    height: MediaQuery.of(context).size.height / 8,
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
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){ print("Find deals button pressed"); },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/find-deals-button.png', 
                fit: BoxFit.scaleDown,
                height: MediaQuery.of(context).size.height / 10,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
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
