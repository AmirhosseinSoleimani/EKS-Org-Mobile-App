import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_request_entity.dart';

class ConfirmInvoiceRequestModel extends ConfirmHomeServiceRequest {
  const ConfirmInvoiceRequestModel({
    super.id,
    super.isAgreed,
    super.isApproved,
    super.serviceRequestId,
    super.canOnlinePay,
  });


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EvaluationId'] = id;
    map['IsAgreed']= isAgreed;
    map['IsApproved'] = isApproved;
    map['ServiceRequestId'] = serviceRequestId;
   // map['canOnlinePay'] = canOnlinePay;
    return map;
  }
}