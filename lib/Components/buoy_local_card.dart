import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class BuoyLocalCardAndSwitch extends StatelessWidget {
  BuoyLocalCardAndSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){ 
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                    title: Text("Your Buoy Local Card"),
                    titlePadding: EdgeInsets.all(20),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    children: <Widget>[
                      Text(
                        "For added security purposes you may lock your buoy Local card any time. \n",
                        style: TextStyle(color: Colors.black45),
                      ),
                      Text(
                        "Buoy Local Card is issued by MetaBank®, Member FDIC.\n",
                        style: TextStyle(color: Colors.black45),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: (){Navigator.of(context).pop();},
                            child: Text("GOT IT", style: TextStyle(color: Colors.indigo[700])),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: MediaQuery.of(context).size.width / 3,
                child: Opacity(
                  opacity: vm.cardLockStatus ? 0.5 : 1.0,
                  child: Image.asset(
                    'images/buoy-local-card-v2.png', 
                    fit: BoxFit.fitWidth, 
                    height: MediaQuery.of(context).size.height / 8,
                    ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Switch(
                  value: !vm.cardLockStatus,
                  onChanged: (bool newValue){ 
                    vm.toggleSwitch();
                  },
                ),
                Container(
                  width: 80,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(vm.cardLockStatus ? "Locked" : "Unlocked"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
