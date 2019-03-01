class AppState {
  final double points;
  final double redeemed;
  final double buoyBucks;
  final bool cardLockStatus;
  final List<dynamic> programMembership;

  AppState({ 
    this.points = 1234.0,
    this.redeemed = 0.0,
    this.buoyBucks = 12.51,
    this.cardLockStatus = true,
    this.programMembership,
  });

  AppState copyWith({double points, double redeemed, double buoyBucks, bool cardLockStatus, List<dynamic> programMembership}) {
    return new AppState(
      points: points ?? this.points,
      redeemed: redeemed ?? this.redeemed,
      buoyBucks: buoyBucks ?? this.buoyBucks,
      cardLockStatus: cardLockStatus ?? this.cardLockStatus,
      programMembership: programMembership ?? this.programMembership,
    );
  }

  @override
  String toString() {
    return "points: $points redeemed: $redeemed, buoyBucks: $buoyBucks, cardLockStatus: $cardLockStatus, programMembership: $programMembership";
  }
}