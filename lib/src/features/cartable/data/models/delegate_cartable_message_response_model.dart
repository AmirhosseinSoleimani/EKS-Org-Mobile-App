import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/delegate_cartable_message_response_entity.dart';

class DelegateCartableMessageResponseModel
    extends DelegateCartableMessageResponseEntity {
  const DelegateCartableMessageResponseModel({
    super.targetMessage,
    super.newMessage,
    super.targetUser,
  });

  factory DelegateCartableMessageResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final targetMessageJson = json['targetMessage'];
    final newMessageJson = json['newMessage'];
    final targetUserJson = json['targetUser'];

    return DelegateCartableMessageResponseModel(
      targetMessage: targetMessageJson is Map
          ? DelegateCartableMessageModel.fromJson(
              Map<String, dynamic>.from(targetMessageJson),
            )
          : null,
      newMessage: newMessageJson is Map
          ? DelegateCartableMessageModel.fromJson(
              Map<String, dynamic>.from(newMessageJson),
            )
          : null,
      targetUser: targetUserJson is Map
          ? DelegateCartableTargetUserModel.fromJson(
              Map<String, dynamic>.from(targetUserJson),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetMessage': targetMessage?.toModel().toJson(),
      'newMessage': newMessage?.toModel().toJson(),
      'targetUser': targetUser?.toModel().toJson(),
    };
  }
}

class DelegateCartableMessageModel extends DelegateCartableMessageEntity {
  const DelegateCartableMessageModel({super.guid});

  factory DelegateCartableMessageModel.fromJson(Map<String, dynamic> json) {
    return DelegateCartableMessageModel(guid: json['guid'] as String?);
  }

  Map<String, dynamic> toJson() => {'guid': guid};
}

class DelegateCartableTargetUserModel extends DelegateCartableTargetUserEntity {
  const DelegateCartableTargetUserModel({
    super.guid,
    super.fullName,
  });

  factory DelegateCartableTargetUserModel.fromJson(Map<String, dynamic> json) {
    return DelegateCartableTargetUserModel(
      guid: json['guid'] as String?,
      fullName: json['fullName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'fullName': fullName,
    };
  }
}
