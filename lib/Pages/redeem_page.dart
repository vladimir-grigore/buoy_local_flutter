import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';
import 'package:buoy/Components/learn_more_modal.dart';
import 'package:buoy/Components/redeem_points_modal.dart';

class RedeemPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){ print("Buoy Bucks clicked"); },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset('images/buoy-bucks-container.png', fit: BoxFit.fitWidth),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('\$${(vm.redeemed.floorToDouble()/100).toString()}', 
                          style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600
                          )
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Redeem"),
                            Text("${vm.redeemed.round().toString()} pts"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Slider(
                  min: 0.0,
                  max: vm.points,
                  value: vm.redeemed,
                  onChanged: (newRating) {
                    vm.modifySlider(newRating);
                  },
                ),
              ),
              RedeemPointsModal(),
              LearnMoreModal(),
            ],
          ),
        );
      }
    );
  }
}