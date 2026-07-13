class ArchiveCartableMessageResponseEntity {
  final String messageGuid;

  const ArchiveCartableMessageResponseEntity({
    required this.messageGuid,
  });

  ArchiveCartableMessageResponseEntity copyWith({
    String? messageGuid,
  }) {
    return ArchiveCartableMessageResponseEntity(
      messageGuid: messageGuid ?? this.messageGuid,
    );
  }
}