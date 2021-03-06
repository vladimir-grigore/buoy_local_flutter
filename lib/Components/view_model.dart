import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/actions/buoy_actions.dart';

class ViewModel {
  final int tabIndex;
  final bool isLoading;
  final double points;
  final double redeemed;
  final double buoyBucks;
  final bool cardLockStatus;
  final VoidCallback toggleSwitch;
  final VoidCallback toggleLoadingScreen;
  final Function(double) modifySlider;
  final Function(double) redeemPoints;
  final Function(dynamic) updateTransactions;
  final Function(dynamic) updateOffers;
  final Map<String, dynamic> programMemnership;
  final Map<String, dynamic> activeTransaction;
  final List offers;
  final List transactions;
  final List offerLocation;

  ViewModel({
    this.tabIndex,
    this.isLoading,
    this.points,
    this.offers,
    this.redeemed,
    this.buoyBucks,
    this.modifySlider,
    this.cardLockStatus,
    this.toggleSwitch,
    this.toggleLoadingScreen,
    this.redeemPoints,
    this.updateTransactions,
    this.updateOffers,
    this.programMemnership,
    this.transactions,
    this.activeTransaction,
    this.offerLocation,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      tabIndex:store.state.tabIndex,
      isLoading: store.state.isLoading,
      points: store.state.points,
      redeemed: store.state.redeemed,
      buoyBucks: store.state.buoyBucks,
      cardLockStatus: store.state.cardLockStatus,
      programMemnership: store.state.programMembership,
      transactions: store.state.transactions,
      activeTransaction: store.state.activeTransaction,
      offers: store.state.offers,
      offerLocation: store.state.offerLocation,
      toggleLoadingScreen: () { store.dispatch(new ToggleLoadingScreenAction()); },
      toggleSwitch: () { store.dispatch(new ToggleBuoyCardLockAction()); },
      modifySlider: (newValue) { store.dispatch(new PointsSliderAction(newValue)); },
      redeemPoints: (redeemed) { store.dispatch(new RedeemPointsAction(redeemed)); },
      updateTransactions: (transactions) { store.dispatch(new UpdateTransactionsAction(transactions)); },
      updateOffers: (offers) { store.dispatch(new UpdateOffersAction(offers)); },
    );
  }
}