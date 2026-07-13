import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/archive_cartable_message_param_entity.dart';

class ArchiveCartableMessageParamModel
    extends ArchiveCartableMessageParamEntity {
  const ArchiveCartableMessageParamModel({
    required super.messageGuid,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageGuid': messageGuid,
    };
  }
}