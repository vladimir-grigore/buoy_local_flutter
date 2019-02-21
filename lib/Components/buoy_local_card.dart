import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/actions/buoy_actions.dart';
import 'package:buoy/model/AppState.dart';

class BuoyLocalCardAndSwitch extends StatelessWidget {
  BuoyLocalCardAndSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){ print("Buoy card clicked"); },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: MediaQuery.of(context).size.width / 3,
                child: Opacity(
                  opacity: vm.cardLockStatus ? 1.0 : 0.5,
                  child: Image.asset(
                    'images/buoy-local-card-v2.png', 
                    fit: BoxFit.fitWidth, 
                    height: MediaQuery.of(context).size.height / 7,
                    ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Switch(
                  value: vm.cardLockStatus,
                  onChanged: (bool newValue){ 
                    vm.toggleSwitch();
                  },
                ),
                Container(
                  width: 80,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(vm.cardLockStatus ? "Unlocked" : "Locked"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ViewModel {
  final bool cardLockStatus;
  final VoidCallback toggleSwitch;

  _ViewModel({this.cardLockStatus, this.toggleSwitch});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      cardLockStatus: store.state.cardLockStatus,
      toggleSwitch: () { store.dispatch(new ToggleBuoyCardLockAction()); },
    );
  }
}