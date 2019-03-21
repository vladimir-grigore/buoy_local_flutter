class RedeemPointsAction {
  final double redeemed;

  RedeemPointsAction(this.redeemed);
}

class ToggleBuoyCardLockAction {}

class ToggleLoadingScreenAction {}

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

class UpdateTabIndexAction {
  final int newIndex;

  UpdateTabIndexAction(this.newIndex);
}