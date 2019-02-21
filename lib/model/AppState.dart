class AppState {
  final double points;
  final double redeemed;
  final double buoyBucks;
  final bool cardLockStatus;

  AppState({ 
    this.points = 1234.0, 
    this.redeemed = 0.0, 
    this.buoyBucks = 12.51, 
    this.cardLockStatus = true 
  });

  AppState copyWith({ double points, double redeemed, double buoyBucks, bool cardLockStatus }){
    return new AppState(
      points: points ?? this.points,
      redeemed: redeemed ?? this.redeemed,
      buoyBucks: buoyBucks ?? this.buoyBucks,
      cardLockStatus: cardLockStatus ?? this.cardLockStatus,
    );
  }

  @override
  String toString() {
    return "AppState = points: $points redeemed: $redeemed, buoyBucks: $buoyBucks, cardLockStatus: $cardLockStatus";
  }
}