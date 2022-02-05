// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      owner: json['owner'] as String,
    )
      ..opponent = json['opponent'] as String?
      ..turn = json['turn'] as int
      ..openRoom = json['openRoom'] as bool
      ..gameOver = json['gameOver'] as bool
      ..ownerWins = json['ownerWins'] as int
      ..opponentWins = json['opponentWins'] as int
      ..id = json['id'] as String?
      ..grid = (json['grid'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'owner': instance.owner,
      'opponent': instance.opponent,
      'turn': instance.turn,
      'openRoom': instance.openRoom,
      'gameOver': instance.gameOver,
      'ownerWins': instance.ownerWins,
      'opponentWins': instance.opponentWins,
      'id': instance.id,
      'grid': instance.grid,
    };
