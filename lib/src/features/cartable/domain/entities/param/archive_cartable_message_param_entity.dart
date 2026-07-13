import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/archive_cartable_message_param_model.dart';

class ArchiveCartableMessageParamEntity {
  final String messageGuid;

  const ArchiveCartableMessageParamEntity({
    required this.messageGuid,
  });

  ArchiveCartableMessageParamModel toModel() {
    return ArchiveCartableMessageParamModel(
      messageGuid: messageGuid,
    );
  }

  ArchiveCartableMessageParamEntity copyWith({
    String? messageGuid,
  }) {
    return ArchiveCartableMessageParamEntity(
      messageGuid: messageGuid ?? this.messageGuid,
    );
  }
}