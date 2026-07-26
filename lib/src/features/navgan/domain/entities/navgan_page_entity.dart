import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';

class NavganPageEntity {
  const NavganPageEntity({
    this.records = const [],
    this.count = 0,
  });

  final List<NavganEntity> records;
  final int count;
}
