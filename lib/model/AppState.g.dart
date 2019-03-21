// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
      tabIndex: json['tabIndex'] as int,
      isLoading: json['isLoading'] as bool,
      points: (json['points'] as num)?.toDouble(),
      redeemed: (json['redeemed'] as num)?.toDouble(),
      buoyBucks: (json['buoyBucks'] as num)?.toDouble(),
      cardLockStatus: json['cardLockStatus'] as bool,
      programMembership: json['programMembership'] as Map<String, dynamic>,
      transactions: json['transactions'] as List);
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'tabIndex': instance.tabIndex,
      'isLoading': instance.isLoading,
      'points': instance.points,
      'redeemed': instance.redeemed,
      'buoyBucks': instance.buoyBucks,
      'cardLockStatus': instance.cardLockStatus,
      'programMembership': instance.programMembership,
      'transactions': instance.transactions
    };
