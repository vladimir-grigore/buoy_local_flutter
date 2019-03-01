class RedeemPointsAction {
  final double redeemed;

  RedeemPointsAction(this.redeemed);
}

class ToggleBuoyCardLockAction {}

class PointsSliderAction {
  final double newValue;

  PointsSliderAction(this.newValue); 
}

class UpdateProgramMembershipAction {
  final List<dynamic> result;

  UpdateProgramMembershipAction(this.result);
}