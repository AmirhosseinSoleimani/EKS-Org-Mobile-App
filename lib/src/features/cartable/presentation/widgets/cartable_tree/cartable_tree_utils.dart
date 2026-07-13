import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';

String createCartableTreePathKey(
    List<SubordinatedUserEntity> path,
    ) {
  return path.map(createCartableTreeNodeSegment).join('>');
}

String createCartableTreeNodeSegment(
    SubordinatedUserEntity item,
    ) {
  final nodeType = item.isUser == true
      ? 'user'
      : 'role';

  return [
    nodeType,
    item.id?.toString() ?? '',
    item.guid?.trim() ?? '',
    item.name?.trim() ?? '',
  ].join(':');
}