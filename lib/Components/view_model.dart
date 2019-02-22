import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/actions/buoy_actions.dart';

class ViewModel {
  final double points;
  final double redeemed;
  final double buoyBucks;
  final bool cardLockStatus;
  final VoidCallback toggleSwitch;
  final Function(double) modifySlider;
  final Function(double) redeemPoints;

  ViewModel({
    this.points, 
    this.redeemed,
    this.buoyBucks,
    this.modifySlider,
    this.cardLockStatus,
    this.toggleSwitch,
    this.redeemPoints,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      points: store.state.points,
      redeemed: store.state.redeemed,
      buoyBucks: store.state.buoyBucks,
      cardLockStatus: store.state.cardLockStatus,
      toggleSwitch: () { store.dispatch(new ToggleBuoyCardLockAction()); },
      modifySlider: (newValue) {store.dispatch(new PointsSliderAction(newValue));},
      redeemPoints: (redeemed) {store.dispatch(new RedeemPointsAction(redeemed));},
    );
  }
}