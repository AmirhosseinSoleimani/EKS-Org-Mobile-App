import 'package:eks_sana_plus_org/src/features/services/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.message});

  factory MessageModel.fromJson(dynamic json) {
    return MessageModel(message: json['message']);
  }

  @override
  MessageModel copyWith({String? message}) =>
      MessageModel(message: message ?? this.message);

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
