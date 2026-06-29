import 'package:eks_sana_plus_org/src/features/cartable/data/models/subordinated_user_model.dart';

class SubordinatedUserEntity {
  final int? id;
  final String? guid;
  final String? name;
  final bool? isRoot;
  final bool? isRole;
  final bool? isUser;
  final int? onlineStatus;
  final int? cartableMessagesCount;
  final bool? hasWorkTimespan;
  final List<SubordinatedUserEntity> subordinateds;

  const SubordinatedUserEntity({
    this.id,
    this.guid,
    this.name,
    this.isRoot,
    this.isRole,
    this.isUser,
    this.onlineStatus,
    this.cartableMessagesCount,
    this.hasWorkTimespan,
    this.subordinateds = const [],
  });

  SubordinatedUserModel toModel() {
    return SubordinatedUserModel(
      id: id,
      guid: guid,
      name: name,
      isRoot: isRoot,
      isRole: isRole,
      isUser: isUser,
      onlineStatus: onlineStatus,
      cartableMessagesCount: cartableMessagesCount,
      hasWorkTimespan: hasWorkTimespan,
      subordinateds: subordinateds
          .map((item) => item.toModel())
          .toList(),
    );
  }

  SubordinatedUserEntity copyWith({
    int? id,
    String? guid,
    String? name,
    bool? isRoot,
    bool? isRole,
    bool? isUser,
    int? onlineStatus,
    int? cartableMessagesCount,
    bool? hasWorkTimespan,
    List<SubordinatedUserEntity>? subordinateds,
  }) {
    return SubordinatedUserEntity(
      id: id ?? this.id,
      guid: guid ?? this.guid,
      name: name ?? this.name,
      isRoot: isRoot ?? this.isRoot,
      isRole: isRole ?? this.isRole,
      isUser: isUser ?? this.isUser,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      cartableMessagesCount:
      cartableMessagesCount ?? this.cartableMessagesCount,
      hasWorkTimespan: hasWorkTimespan ?? this.hasWorkTimespan,
      subordinateds: subordinateds ?? this.subordinateds,
    );
  }
}