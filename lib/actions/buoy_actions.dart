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

class UpdateActiveTransactionAction {
  final Map<String, dynamic> result;

  UpdateActiveTransactionAction(this.result);
}

class UpdateTabIndexAction {
  final int newIndex;

  UpdateTabIndexAction(this.newIndex);
}

class UpdateOffersAction {
  final Map<String, dynamic> result;

  UpdateOffersAction(this.result);
}
