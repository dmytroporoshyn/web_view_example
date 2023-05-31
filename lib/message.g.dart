// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      type: $enumDecode(_$MessageTypeEnumMap, json['type'],
          unknownValue: MessageType.data),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'type': _$MessageTypeEnumMap[instance.type]!,
      'data': instance.data,
    };

const _$MessageTypeEnumMap = {
  MessageType.snackbar: 'snackbar',
  MessageType.dialog: 'dialog',
  MessageType.data: 'data',
};
