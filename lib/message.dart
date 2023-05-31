
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

enum MessageType {snackbar, dialog, data}

@JsonSerializable()
class Message {
  Message({
    required this.type,
    required this.data,
  });

  @JsonKey(unknownEnumValue: MessageType.data)
  final MessageType type;
  final String? data;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}