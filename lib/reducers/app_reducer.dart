import 'package:buoy/model/AppState.dart';
import 'package:buoy/actions/buoy_actions.dart';

AppState appReducer(AppState state, action) {
  if (action is RedeemPointsAction){
    return redeemPoints(state, action);
  } else if (action is ToggleBuoyCardLockAction) {
    return toggleCardLock(state);
  } else if (action is PointsSliderAction) {
    return modifySlider(state, action);
  } else {
    return state;
  }
}

AppState redeemPoints(AppState state, RedeemPointsAction action) {
  return new AppState(
    points: state.points - action.redeemed,
    redeemed: 0.0,
    buoyBucks: state.buoyBucks + (action.redeemed / 100),
    cardLockStatus: state.cardLockStatus,
  );
}

AppState toggleCardLock(AppState state) {
  return new AppState(
    points: state.points,
    redeemed: state.redeemed,
    buoyBucks: state.buoyBucks,
    cardLockStatus: !state.cardLockStatus,
  );
}

AppState modifySlider(AppState state, PointsSliderAction action) {
  return new AppState(
    points: state.points,
    redeemed: state.redeemed,
    buoyBucks: state.buoyBucks,
    cardLockStatus: !state.cardLockStatus,
  );
}
