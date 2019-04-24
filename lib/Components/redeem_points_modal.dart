import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class RedeemPointsModal extends StatelessWidget {
  RedeemPointsModal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          child: RaisedButton(
            onPressed: vm.redeemed > 0 ? () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Redeem Points"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            "Confirm you want to redeem ${vm.redeemed.round()} points for \$${vm.redeemed.round()/100} of Buoy Bucks. Terms and conditions apply.",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("CANCEL"),
                        onPressed: () {Navigator.of(context).pop();},
                      ),
                      FlatButton(
                        child: Text("CONFIRM"),
                        onPressed: () {
                          vm.redeemPoints(vm.redeemed);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
            } : null,
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            disabledTextColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text("REDEEM POINTS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          ),
        );
      },
    );

  }
}