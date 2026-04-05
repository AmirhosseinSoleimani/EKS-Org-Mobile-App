import 'package:eks_sana_plus_org/src/shared/widgets/dialog_widget/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_history_invoice_state.freezed.dart';

@freezed
class RequestHistoryInvoiceState with _$RequestHistoryInvoiceState {

  const factory RequestHistoryInvoiceState.idle() = RequestHistoryInvoiceIdleState;

  const factory RequestHistoryInvoiceState.error({required DialogDataModel dialogDataModel}) = RequestHistoryInvoiceErrorState;

  const factory RequestHistoryInvoiceState.loading() = RequestHistoryInvoiceLoadingState;

  const factory RequestHistoryInvoiceState.success() = RequestHistoryInvoiceSuccessState;

  const factory RequestHistoryInvoiceState.connectionError() = _ConnectionError;

}
