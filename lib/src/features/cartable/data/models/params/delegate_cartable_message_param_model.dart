import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/delegate_cartable_message_param_entity.dart';

class DelegateCartableMessageParamModel
    extends DelegateCartableMessageParamEntity {
  const DelegateCartableMessageParamModel({
    required super.messageGuid,
    required super.targetUserGuid,
  });

  Map<String, dynamic> toJson() {
    return {
      'MessageGuid': messageGuid,
      'TargetUserGuid': targetUserGuid,
    };
  }
}
