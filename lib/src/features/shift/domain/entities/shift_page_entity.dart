import 'shift_entity.dart';

class ShiftPageEntity {
  const ShiftPageEntity({
    required this.records,
    required this.count,
  });

  final List<ShiftEntity> records;
  final int count;
}
