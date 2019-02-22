import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class BuoyHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        double spinnerValue = vm.redeemed == 0.0 ? 1.0 : (vm.points - vm.redeemed) / vm.points;

        return Stack(
          alignment: Alignment(0.0, 0.0),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/header-bangor-image.png', 
                fit: BoxFit.fitWidth, 
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Column(
                children: <Widget>[
                  Text("MY POINTS", 
                    style: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5
                    )
                  ),
                  Text("${(vm.points - vm.redeemed).toInt()}", style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment(0.0, 1.3),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 30.0),
                    width: MediaQuery.of(context).size.width / 5,
                    child: Image.asset(
                      'images/points-buoy.png', 
                      fit: BoxFit.fitWidth, 
                    ),
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(-131 / 360),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                        value: spinnerValue / 1.5,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset(
                      'images/waves-header.png', 
                      fit: BoxFit.fitWidth, 
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );    
  }
}
