import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';

typedef CartableSelectionCallback = Future<void> Function(
    SubordinatedUserEntity selectedItem,
    List<SubordinatedUserEntity> selectedPath,
    );

typedef TreeNodeToggleCallback = void Function(
    String nodeKey,
    );

typedef TreeNodeSelectionCallback = void Function({
required SubordinatedUserEntity item,
required List<SubordinatedUserEntity> path,
required String nodeKey,
});