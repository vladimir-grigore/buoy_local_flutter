import 'package:buoy/model/AppState.dart';
import 'package:buoy/actions/buoy_actions.dart';

AppState appReducer(AppState state, action) {
  if (action is RedeemPointsAction){
    return redeemPoints(state, action);
  } else if (action is ToggleBuoyCardLockAction) {
    return toggleCardLock(state);
  } else if (action is PointsSliderAction) {
    return modifySlider(state, action);
  } else if (action is UpdateProgramMembershipAction) {
    return updateProgramMembershipData(state, action);
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
  return state.copyWith(cardLockStatus: !state.cardLockStatus);
}

AppState modifySlider(AppState state, PointsSliderAction action) {
  return state.copyWith(redeemed: action.newValue);
}

AppState updateProgramMembershipData(AppState state, UpdateProgramMembershipAction action){
  return state.copyWith(programMembership: action.result);
}
