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
  final Map<String, dynamic> result;

  UpdateProgramMembershipAction(this.result);
}

class UpdateTransactionsAction {
  final Map<String, dynamic> result;

  UpdateTransactionsAction(this.result);
}
