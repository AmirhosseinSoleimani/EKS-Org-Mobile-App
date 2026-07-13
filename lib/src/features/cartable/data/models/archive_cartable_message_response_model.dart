import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/archive_cartable_message_response_entity.dart';

class ArchiveCartableMessageResponseModel
    extends ArchiveCartableMessageResponseEntity {
  const ArchiveCartableMessageResponseModel({
    required super.messageGuid,
  });

  factory ArchiveCartableMessageResponseModel.fromJson(
      dynamic json,
      ) {
    return ArchiveCartableMessageResponseModel(
      messageGuid: json?.toString() ?? '',
    );
  }

  ArchiveCartableMessageResponseEntity toEntity() {
    return ArchiveCartableMessageResponseEntity(
      messageGuid: messageGuid,
    );
  }

  @override
  ArchiveCartableMessageResponseModel copyWith({
    String? messageGuid,
  }) {
    return ArchiveCartableMessageResponseModel(
      messageGuid: messageGuid ?? this.messageGuid,
    );
  }
}