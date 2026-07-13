import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/delegate_cartable_message_param_model.dart';

class DelegateCartableMessageParamEntity {
  final String messageGuid;
  final String targetUserGuid;

  const DelegateCartableMessageParamEntity({
    required this.messageGuid,
    required this.targetUserGuid,
  });

  DelegateCartableMessageParamModel toModel() {
    return DelegateCartableMessageParamModel(
      messageGuid: messageGuid,
      targetUserGuid: targetUserGuid,
    );
  }

  DelegateCartableMessageParamEntity copyWith({
    String? messageGuid,
    String? targetUserGuid,
  }) {
    return DelegateCartableMessageParamEntity(
      messageGuid: messageGuid ?? this.messageGuid,
      targetUserGuid: targetUserGuid ?? this.targetUserGuid,
    );
  }
}
