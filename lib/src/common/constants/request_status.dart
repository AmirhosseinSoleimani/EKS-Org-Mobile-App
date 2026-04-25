import 'package:flutter/material.dart';

import '../../shared/widgets/filter_widgets/interfaces/dropdown_item.dart';

enum RequestStatus implements DropdownItem {
  openRequests(-100, 'درخواست های باز'),
  waitingPreInvoiceApproval(-4, 'در انتظار تایید پیش‌فاکتور'),
  waitingAddress(-3, 'در انتظار ثبت آدرس'),
  waitingInfoCompletion(-2, 'در انتظار تکمیل اطلاعات'),
  waitingForDetails(-1, 'در انتظار تکمیل اطلاعات'),
  unknown(0, 'نامشخص'),
  waitingAssignment(1, 'در انتظار تخصیص'),
  canceled(2, 'لغو'),
  dispatched(3, 'اعزام شده'),
  onTheWay(4, 'حرکت کرده'),
  arrived(5, 'رسیده است'),
  inProgress(6, 'در حال انجام عملیات'),
  completed(7, 'اتمام کار'),
  reserved(8, 'رزرو'),
  closed(9, 'بسته');

  final int value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) {
    return null;
  }

  const RequestStatus(this.value, this.label);

  static RequestStatus fromValue(int? value) {
    return RequestStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => RequestStatus.unknown,
    );
  }

  bool get isActive {
    switch (this) {
      case RequestStatus.waitingAssignment:
      case RequestStatus.dispatched:
      case RequestStatus.onTheWay:
      case RequestStatus.arrived:
      case RequestStatus.inProgress:
      case RequestStatus.waitingPreInvoiceApproval:
      case RequestStatus.waitingAddress:
      case RequestStatus.waitingInfoCompletion:
      case RequestStatus.reserved:
      case RequestStatus.waitingForDetails:
        return true;
      default:
        return false;
    }
  }
}
