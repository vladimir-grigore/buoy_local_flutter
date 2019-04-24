import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class BuoyBucks extends StatelessWidget {
  BuoyBucks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return new StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm){
        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            GestureDetector(
              onTap: (){ print("Buoy Bucks clicked"); },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: MediaQuery.of(context).size.width / 3,
                child: Image.asset(
                  'images/buoy-bucks-container.png', 
                  fit: BoxFit.fitWidth, 
                  height: MediaQuery.of(context).size.height / 5.5,
                  ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 10,
              alignment: Alignment.center,
              // padding: EdgeInsets.only(bottom: 10.0),
              child: Text("\$${vm.buoyBucks.toStringAsFixed(2)}", 
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)
              ),
            ),
          ],
        );
      },
    );
  }
}
