import 'package:eks_sana_plus_org/src/features/services/data/models/message_model.dart';

class MessageEntity {
  final String message;

  MessageEntity({required this.message});

  MessageEntity copyWith({String? message}) {
    return MessageEntity(message: message ?? this.message);
  }

  MessageModel toModel() {
    return MessageModel(message: message);
  }
}
