import 'package:eks_sana_plus_org/src/features/cartable/data/models/delegate_cartable_message_response_model.dart';

class DelegateCartableMessageResponseEntity {
  final DelegateCartableMessageEntity? targetMessage;
  final DelegateCartableMessageEntity? newMessage;
  final DelegateCartableTargetUserEntity? targetUser;

  const DelegateCartableMessageResponseEntity({
    this.targetMessage,
    this.newMessage,
    this.targetUser,
  });

  DelegateCartableMessageResponseModel toModel() {
    return DelegateCartableMessageResponseModel(
      targetMessage: targetMessage?.toModel(),
      newMessage: newMessage?.toModel(),
      targetUser: targetUser?.toModel(),
    );
  }

  DelegateCartableMessageResponseEntity copyWith({
    DelegateCartableMessageEntity? targetMessage,
    DelegateCartableMessageEntity? newMessage,
    DelegateCartableTargetUserEntity? targetUser,
  }) {
    return DelegateCartableMessageResponseEntity(
      targetMessage: targetMessage ?? this.targetMessage,
      newMessage: newMessage ?? this.newMessage,
      targetUser: targetUser ?? this.targetUser,
    );
  }
}

class DelegateCartableMessageEntity {
  final String? guid;

  const DelegateCartableMessageEntity({this.guid});

  DelegateCartableMessageModel toModel() {
    return DelegateCartableMessageModel(guid: guid);
  }

  DelegateCartableMessageEntity copyWith({String? guid}) {
    return DelegateCartableMessageEntity(guid: guid ?? this.guid);
  }
}

class DelegateCartableTargetUserEntity {
  final String? guid;
  final String? fullName;

  const DelegateCartableTargetUserEntity({
    this.guid,
    this.fullName,
  });

  DelegateCartableTargetUserModel toModel() {
    return DelegateCartableTargetUserModel(
      guid: guid,
      fullName: fullName,
    );
  }

  DelegateCartableTargetUserEntity copyWith({
    String? guid,
    String? fullName,
  }) {
    return DelegateCartableTargetUserEntity(
      guid: guid ?? this.guid,
      fullName: fullName ?? this.fullName,
    );
  }
}
