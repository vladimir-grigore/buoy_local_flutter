import 'package:json_annotation/json_annotation.dart';

part 'AppState.g.dart';

@JsonSerializable()
class AppState {
  final bool isLoading;
  final double points;
  final double redeemed;
  final double buoyBucks;
  final bool cardLockStatus;
  final Map<String, dynamic> programMembership;
  final List transactions;

  AppState({
    this.isLoading = false,
    this.points = 1234.0,
    this.redeemed = 0.0,
    this.buoyBucks = 12.51,
    this.cardLockStatus = false,
    this.programMembership,
    this.transactions,
  });

  AppState copyWith({bool isLoading, double points, double redeemed, double buoyBucks, bool cardLockStatus, Map<String, dynamic> programMembership, List transactions}) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      points: points ?? this.points,
      redeemed: redeemed ?? this.redeemed,
      buoyBucks: buoyBucks ?? this.buoyBucks,
      cardLockStatus: cardLockStatus ?? this.cardLockStatus,
      programMembership: programMembership ?? this.programMembership,
      transactions: transactions ?? this.transactions,
    );
  }

  // Json encoding needed to connect to the Remote Developer Tools middleware
  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  String toString() {
    return "points: $points redeemed: $redeemed, buoyBucks: $buoyBucks, cardLockStatus: $cardLockStatus";
  }
}