import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';

class GeneralContentPageEntity {
  const GeneralContentPageEntity({
    this.records = const [],
    this.count = 0,
  });

  final List<GeneralContentEntity> records;
  final int count;
}
