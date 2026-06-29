import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';

class SubordinatedUserModel extends SubordinatedUserEntity {
  const SubordinatedUserModel({
    super.id,
    super.guid,
    super.name,
    super.isRoot,
    super.isRole,
    super.isUser,
    super.onlineStatus,
    super.cartableMessagesCount,
    super.hasWorkTimespan,
    super.subordinateds,
  });

  factory SubordinatedUserModel.fromJson(Map<String, dynamic> json) {
    return SubordinatedUserModel(
      id: json['id'] as int? ?? 0,
      guid: json['guid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isRoot: json['isRoot'] as bool? ?? false,
      isRole: json['isRole'] as bool? ?? false,
      isUser: json['isUser'] as bool? ?? false,
      onlineStatus: json['onlineStatus'] as int? ?? 0,
      cartableMessagesCount: json['cartableMessagesCount'] as int?,
      hasWorkTimespan: json['hasWorkTimespan'] as bool?,
      subordinateds: (json['subordinateds'] as List<dynamic>? ?? [])
          .map(
            (item) => SubordinatedUserModel.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guid': guid,
      'name': name,
      'isRoot': isRoot,
      'isRole': isRole,
      'isUser': isUser,
      'onlineStatus': onlineStatus,
      'cartableMessagesCount': cartableMessagesCount,
      'hasWorkTimespan': hasWorkTimespan,
      'subordinateds': subordinateds
          .map((item) => item.toModel().toJson())
          .toList(),
    };
  }
}