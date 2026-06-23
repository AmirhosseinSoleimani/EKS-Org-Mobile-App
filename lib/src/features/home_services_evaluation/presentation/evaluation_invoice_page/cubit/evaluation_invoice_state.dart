part of 'evaluation_invoice_cubit.dart';

@freezed
class EvaluationInvoiceState with _$EvaluationInvoiceState {
  const factory EvaluationInvoiceState.idle() = _Idle;

  const factory EvaluationInvoiceState.loading() = _Loading;

  const factory EvaluationInvoiceState.loaded() = _Loaded;

  const factory EvaluationInvoiceState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory EvaluationInvoiceState.connectionError() = _ConnectionError;

  const factory EvaluationInvoiceState.submitLoading() = _SubmitLoading;

  const factory EvaluationInvoiceState.submitSuccess() = _SubmitSuccess;
}
